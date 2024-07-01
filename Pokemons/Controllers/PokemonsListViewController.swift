//
//  ViewController.swift
//  Pokemons
//
//  Created by Дарья Балацун on 23.06.24.
//

import UIKit

final class PokemonsListViewController: UIViewController {

    private let pokemonListView = PokemonsListView()
    private let viewModel = PokemonsListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(
            red: 11/255,
            green: 17/255,
            blue: 36/255,
            alpha: 1
        )
        title = "Pokemons".uppercased()
        setupViews()
        viewModel.delegate = self
        viewModel.fetchPokemons()
    }
}

extension PokemonsListViewController {
    func setupViews() {
        setupPokemonListView()
    }
    
    func setupPokemonListView() {
        view.addSubview(pokemonListView)
        
        NSLayoutConstraint.activate([
            pokemonListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pokemonListView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            pokemonListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            pokemonListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension PokemonsListViewController: PokemonsListViewModelDelegate {
    func didFetchInitialPokemons() {
        pokemonListView.configure(with: viewModel)
    }
}
