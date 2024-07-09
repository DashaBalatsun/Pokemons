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
        viewModel.fetchPokemons()
        viewModel.delegate = self
        pokemonListView.delegate = self
    }
}

extension PokemonsListViewController {
    func setupViews() {
        setupPokemonListView()
        setupNavBar()
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
    
    func setupNavBar() {
        title = "Pokemons"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let navBarAppereance = UINavigationBarAppearance()
        navBarAppereance.configureWithOpaqueBackground()
        navBarAppereance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppereance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navBarAppereance.backgroundColor = UIColor(
            red: 11/255,
            green: 17/255,
            blue: 36/255,
            alpha: 200/25
        )
        
        navigationController?.navigationBar.standardAppearance = navBarAppereance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppereance
    }
}

extension PokemonsListViewController: PokemonsListViewModelDelegate {
    func didFetchInitialPokemons() {
        pokemonListView.configure(with: viewModel)
    }
}

extension PokemonsListViewController: PokemonsListViewDelegate {
    func pokemonListView(_ pokemonList: PokemonsListView, didSelect pokemon: PokemonDetailsViewModel) {
        let vc = PokemonDetailsViewController(viewModel: pokemon)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.present(vc, animated: true)
    }
}
