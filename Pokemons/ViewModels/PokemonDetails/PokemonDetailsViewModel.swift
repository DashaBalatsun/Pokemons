//
//  PokemonDetailsViewModel.swift
//  Pokemons
//
//  Created by Дарья Балацун on 23.06.24.
//

import UIKit

final class PokemonDetailsViewModel {
    
    var pokemonDetails: PokemonDetails?
    
    init(pokemonDetails: PokemonDetails) {
        self.pokemonDetails = pokemonDetails
    }
    
    func getTypesPokemonFirstView() -> PokemonTypeView.PokemonType {
        let model: PokemonTypeView.PokemonType = .init(
            typeName: pokemonDetails?.types[0].type.name.capitalized ?? "",
            typeIcon: pokemonDetails?.types[0].type.name ?? "",
            color: pokemonDetails?.types[0].type.name ?? ""
        )
        return model
    }
    
    func getTypesPokemonSecondtView() -> PokemonTypeView.PokemonType {
        let count = pokemonDetails?.types.count
        if  count == 2 {
            let model: PokemonTypeView.PokemonType = .init(
                typeName: pokemonDetails?.types[1].type.name.capitalized ?? "",
                typeIcon: pokemonDetails?.types[1].type.name ?? "",
                color: pokemonDetails?.types[1].type.name ?? ""
            )
            return model
        } else {
            let model: PokemonTypeView.PokemonType = .init(
                typeName: "",
                typeIcon: "",
                color: ""
            )
            return model
        }
    }
    
    func getWeightViewModel() -> PokemonViewForParameters.PokemonViewForParametersModel {
        let model: PokemonViewForParameters.PokemonViewForParametersModel = .init(
            parameter: pokemonDetails?.weight,
            parameterName: "Weight",
            unit: "kg",
            parameterImage: UIImage(systemName: "scalemass.fill")
        )
        
        return model
    }
    
    func getHeightViewModel() -> PokemonViewForParameters.PokemonViewForParametersModel {
        let model: PokemonViewForParameters.PokemonViewForParametersModel = .init(
            parameter: pokemonDetails?.height,
            parameterName: "Height",
            unit: "m",
            parameterImage: UIImage(systemName: "ruler.fill")
        )
        
        return model
    }
    
    func getParametersModel() -> PokemonParametersView.PokemonParametersViewModel {
        let heightViewModel = self.getHeightViewModel()
        let weightViewModel = self.getWeightViewModel()
        let model: PokemonParametersView.PokemonParametersViewModel = .init(
            heightParameter: heightViewModel,
            weightParameter: weightViewModel
        )
        return model
    }
}
