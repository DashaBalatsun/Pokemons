//
//  PokemonsListView.swift
//  Pokemons
//
//  Created by Дарья Балацун on 23.06.24.
//

import UIKit

protocol PokemonsListViewDelegate: AnyObject {
    func pokemonListView(_ pokemonList: PokemonsListView, didSelect pokemon: PokemonDetailsViewModel)
}

final class PokemonsListView: UIView {
     
    weak var delegate: PokemonsListViewDelegate?
    
    private var viewModel: PokemonsListViewModel? {
        didSet {
            spinner.stopAnimating()
            tableView.isHidden = false
            tableView.reloadData()
            UIView.animate(withDuration: 0.3) {
                self.tableView.alpha = 1
            }
        }
    }
    private let tableView = UITableView()
    private let spinner = UIActivityIndicatorView(style: .large)
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
        spinner.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with viewModel: PokemonsListViewModel) {
        self.viewModel = viewModel
    }
}

extension PokemonsListView {
    func setupViews() {
        setupTableView()
        setupSpinner()
    }
    
    func setupSpinner() {
        addSubview(spinner)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func setupTableView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isHidden = true
        tableView.alpha = 0
        tableView.separatorColor = .clear
        tableView.backgroundColor = UIColor(
            red: 11/255,
            green: 17/255,
            blue: 36/255,
            alpha: 200/255
        )
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PokemonListTableViewCell.self, forCellReuseIdentifier: PokemonListTableViewCell.cellIdentifier)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5.0),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension PokemonsListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.cellViewModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonListTableViewCell.cellIdentifier, for: indexPath) as? PokemonListTableViewCell else { fatalError() }
        guard let cellViewModels = viewModel?.cellViewModels else { fatalError() }
        let cellViewModel = cellViewModels[indexPath.row]
        cell.configure(with: cellViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let viewModel = viewModel else { return }
        viewModel.selectRow(atIndexPath: indexPath)
        delegate?.pokemonListView(self, didSelect: viewModel.viewModelForSelectedRow()!)
    }
}

extension PokemonsListView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let viewModel = viewModel,
              !viewModel.cellViewModels.isEmpty,
              !viewModel.isLoadingMorePokemons else { return }
        
        Timer.scheduledTimer(withTimeInterval: 0.2 , repeats: false) { [weak self] t in
            let offset = scrollView.contentOffset.y
            let totalContentHieght = scrollView.contentSize.height
            let totalScrolViewFixedHeight = scrollView.frame.size.height
            
            if offset >= (totalContentHieght - totalScrolViewFixedHeight - 120) {
                DispatchQueue.main.async {
                    self?.showLoadingIndicator()
                }
                viewModel.fetchAdditionalPokemons()
                
                DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
                    self?.tableView.reloadData()
                })
            }
            t.invalidate()
        }
    }

    private func showLoadingIndicator() {
        let footer = TableLoadingFooterView()
        footer.frame = CGRect(x: 0, y: 0, width: frame.width, height: 100)
        tableView.tableFooterView = footer
    }
}
