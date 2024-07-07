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
    
    private var selectedIndexPath: IndexPath?
    private var pokemonsNext: String?
    
    public var isLoadingMorePokemons = false
    
    public private(set) var cellViewModels: [PokemonListTableViewCellViewModel] = []
    
    
    init() {}
    
    public func fetchPokemons() {
        NetworkManager.shared.fetchData(
            url: EverythingEndpoint.pokemons.request.url,
            expecting: Pokemons.self)
        { [weak self] result in
            switch result {
            case .success(let success):
                self?.pokemonsNext = success.next
                self?.pokemons = success.results
                DispatchQueue.main.async {
                    self?.delegate?.didFetchInitialPokemons()
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    // MARK: - Paginate if adidtional pokemons  are needed
    public func fetchAdditionalPokemons()  {
        guard !isLoadingMorePokemons else {
            return
        }
        
       guard let nextUrlString = pokemonsNext,
             let url = URL(string: nextUrlString) else { return }
        
        print("\(url)")
        isLoadingMorePokemons = true
        
        NetworkManager.shared.fetchData(
            url: url,
            expecting: Pokemons.self)
        { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let success):
                let next = success.next
                let moreResults = success.results
                strongSelf.pokemonsNext = next
                strongSelf.cellViewModels.append(contentsOf: moreResults.compactMap(({
                    return PokemonListTableViewCellViewModel(pokemon: $0)
                })))
                
                DispatchQueue.main.async {
                    strongSelf.isLoadingMorePokemons = false
                }
            case .failure(let failure):
                print(String(describing: failure))
                strongSelf.isLoadingMorePokemons = false
            }
        }
    }

    
    func viewModelForSelectedRow() -> PokemonDetailsViewModel? {
        guard let selectedIndexPath = selectedIndexPath,
              let pokemonModel = cellViewModels[selectedIndexPath.row].pokemonDetails else { return nil }
        let viewModel = PokemonDetailsViewModel(pokemonDetails: pokemonModel)
        return viewModel
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }

}
