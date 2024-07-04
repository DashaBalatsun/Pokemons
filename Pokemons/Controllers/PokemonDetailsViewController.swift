//
//  PokemonDetailsViewController.swift
//  Pokemons
//
//  Created by Дарья Балацун on 23.06.24.
//

import UIKit

final class PokemonDetailsViewController: UIViewController {
    
    private let pokemonDetailsView = PokemonDetailsView()
    private let viewModel: PokemonDetailsViewModel?
    
    init(viewModel: PokemonDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(
            red: 11/255,
            green: 17/255,
            blue: 36/255,
            alpha: 200/25
        )
        pokemonDetailsView.delegate = self
        setupViews()
    }
    
//    func setupNavigationBar() {
//        let titleLabel = UILabel()
//        titleLabel.textColor = .white
//        titleLabel.font = UIFont.boldSystemFont(ofSize: 10.0)
//        titleLabel.sizeToFit()
//        
//        navigationItem.titleView = titleLabel
//        navigationController?.navigationBar.tintColor = .white
//        navigationItem.largeTitleDisplayMode = .never
//    }
}

extension PokemonDetailsViewController {
    func setupViews() {
        setupPokemonDetailsView()
    }
    
    func setupPokemonDetailsView() {
        view.addSubview(pokemonDetailsView)
        
        NSLayoutConstraint.activate([
            pokemonDetailsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pokemonDetailsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            pokemonDetailsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            pokemonDetailsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension PokemonDetailsViewController: PokemonDetailsViewModelDelegate {
    func didFetchPokemonDetails() {
        guard let viewModel = viewModel else { return }
        pokemonDetailsView.configure(with: viewModel)
    }
}
