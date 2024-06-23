//
//  PokemonListTableViewCellViewModel.swift
//  Pokemons
//
//  Created by Дарья Балацун on 23.06.24.
//

import Foundation

struct PokemonListTableViewCellViewModel {
    let name: String?
    let imageURL: String?
    let gameIndex: String?
}

extension String {
    func firstChartOnly() -> String {
        return prefix(1).uppercased() + self.dropFirst()
    }
}
