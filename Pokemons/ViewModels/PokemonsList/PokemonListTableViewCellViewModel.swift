//
//  PokemonListTableViewCellViewModel.swift
//  Pokemons
//
//  Created by Дарья Балацун on 23.06.24.
//

import Foundation

final class PokemonListTableViewCellViewModel: Hashable, Equatable {
    
    private var pokemon: Pokemons.Result
    private var pokemonDetails: PokemonDetails?
    private var selectedIndexPath: IndexPath?
    
    public var name: String {
        return pokemon.name.capitalized
    }
    
    public var imageURL: String {
        return pokemonDetails?.sprites.frontDefault ?? ""
    }
    
    init(pokemon: Pokemons.Result) {
        self.pokemon = pokemon
        loadDetailsPokemon()
    }
    
    private func loadDetailsPokemon() {
        NetworkManager.shared.fetchData(url: URL(string: pokemon.url), expecting: PokemonDetails.self) { [weak self] result in
            switch result {
            case .success(let success):
                self?.pokemonDetails = success
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func viewModelForSelectedRow() -> PokemonDetailsViewModel? {
        guard let selectedIndexPath = selectedIndexPath,
              let pokemonModel = pokemonDetails?[selectedIndexPath.row] else { return nil }
        let viewModel = PokemonDetailsViewModel(pokemonDetails: pokemonModel)
        return viewModel
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
    
    static func == (lhs: PokemonListTableViewCellViewModel, rhs: PokemonListTableViewCellViewModel) -> Bool {
        return lhs.pokemon.name == rhs.pokemon.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(imageURL)
    }
}
