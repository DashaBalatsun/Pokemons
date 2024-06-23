//
//  PokemonsListViewModel.swift
//  Pokemons
//
//  Created by Дарья Балацун on 23.06.24.
//

import Foundation

final class PokemonsListViewModel {
    
    private var pokemons: [Pokemons] = []
    private var cellViewModels: [String] = []
    
    private var hasMoreResults: Bool {
        return false
    }
    
    init() {
        
    }
    
    public func fetchPokemons() {
        
    }
}
