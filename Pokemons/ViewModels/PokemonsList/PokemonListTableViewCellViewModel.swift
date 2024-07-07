//
//  PokemonListTableViewCellViewModel.swift
//  Pokemons
//
//  Created by Дарья Балацун on 23.06.24.
//

import Foundation

final class PokemonListTableViewCellViewModel: Hashable, Equatable {
    
    private var pokemonResult: Pokemons.Result
    public var pokemonDetails: PokemonDetails?
    
    
    public var name: String {
        return pokemonResult.name.capitalized
    }
    
    public var imageURL: String {
        return pokemonDetails?.sprites.frontDefault ?? ""
    }
    
    init(pokemon: Pokemons.Result) {
        self.pokemonResult = pokemon
        loadDetailsPokemon()
    }
    
    private func loadDetailsPokemon() {
        NetworkManager.shared.fetchData(url: URL(string: pokemonResult.url), expecting: PokemonDetails.self) { [weak self] result in
            switch result {
            case .success(let success):
                self?.pokemonDetails = success
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    static func == (lhs: PokemonListTableViewCellViewModel, rhs: PokemonListTableViewCellViewModel) -> Bool {
        return lhs.pokemonResult.name == rhs.pokemonResult.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(imageURL)
    }
}
