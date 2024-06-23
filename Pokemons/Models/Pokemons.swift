//
//  Pokemons.swift
//  Pokemons
//
//  Created by Дарья Балацун on 23.06.24.
//

import Foundation

struct Pokemons: Decodable {
    let count: Int
    let next: String
    let previous: String?
    let results: [Result]
    let details: PokemonDetails?
   
    struct Result: Decodable, Equatable {
        let name: String
        let url: String
    }
}


struct PokemonDetails: Decodable {
    let abilities: [Abilities]
    let gameIndices: [GameIndices]
    let name: String
    let id: Int
    let sprites: Sprites
    let height: Int
    let weight: Int
    let types: [TypeID]
    
    struct GameIndices: Decodable {
        let gameIndex: Int
    }

    struct Sprites: Decodable {
        let other: Other
        let frontDefault: String
        
        struct Other: Decodable {
            let home: Home
            
            struct Home: Decodable {
                let frontDefault: String
            }
        }
    }
    
    struct Abilities: Decodable {
        let ability: Ability
        
        struct Ability: Decodable {
            let name: String
        }
    }

    struct TypeID: Decodable {
        let slot: Int
        let type: TypeInfo

        struct TypeInfo: Decodable {
            let name: String
        }
    }
}


