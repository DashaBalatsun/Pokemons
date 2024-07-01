//
//  PokemonsListView.swift
//  Pokemons
//
//  Created by Дарья Балацун on 23.06.24.
//

import UIKit

final class PokemonsListView: UIView {
     
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
}
