//
//  PokemonListTableViewCellViewModel.swift
//  Pokemons
//
//  Created by Дарья Балацун on 23.06.24.
//

import Foundation

final class PokemonListTableViewCellViewModel: Hashable, Equatable {
    
    private var pokemon: Pokemons.Result
    private var pokemonImage: String
    
    public var name: String {
        return pokemon.name.capitalized
    }
    
    public var imageURL: String {
        return pokemonImage
    }
    
    init(pokemon: Pokemons.Result, pokemonImage: String = "") {
        self.pokemon = pokemon
        self.pokemonImage = pokemonImage
        loadDetailsPokemon()
    }
    
    private func loadDetailsPokemon() {
        NetworkManager.shared.fetchData(url: URL(string: pokemon.url), expecting: PokemonDetails.self) { [weak self] result in
            switch result {
            case .success(let success):
                self?.pokemonImage = success.sprites.frontDefault
            case .failure(let failure):
                print(failure)
            }
            
        }
    }
    
    static func == (lhs: PokemonListTableViewCellViewModel, rhs: PokemonListTableViewCellViewModel) -> Bool {
        return lhs.pokemon.name == rhs.pokemon.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(imageURL)
    }
}

extension String {
    func firstChartOnly() -> String {
        return prefix(1).uppercased() + self.dropFirst()
    }
}
