//
//  PokemonsListViewModel.swift
//  Pokemons
//
//  Created by Дарья Балацун on 23.06.24.
//

import Foundation

protocol PokemonsListViewModelDelegate: AnyObject {
    func didFetchInitialPokemons()
}

final class PokemonsListViewModel {
    
    weak var delegate: PokemonsListViewModelDelegate?
   
    private var pokemons: [Pokemons.Result] = [] {
        didSet {
            for pokemon in pokemons {
                let cellViewModel = PokemonListTableViewCellViewModel(pokemon: pokemon)
                if !cellViewModels.contains(cellViewModel) {
                    cellViewModels.append(cellViewModel)
                }
            }
        }
    }
    
   public private(set) var cellViewModels: [PokemonListTableViewCellViewModel] = []
    
    private var hasMoreResults: Bool {
        return false
    }
    
    init() {
        
    }
    
    public func fetchPokemons() {
        NetworkManager.shared.fetchData(
            url: EverythingEndpoint.pokemons.request.url,
            expecting: Pokemons.self)
        { [weak self] result in
            switch result {
            case .success(let success):
                self?.pokemons = success.results
                DispatchQueue.main.async {
                    self?.delegate?.didFetchInitialPokemons()
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
