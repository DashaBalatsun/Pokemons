//
//  PokemonTypeView.swift
//  Pokemons
//
//  Created by Дарья Балацун on 2.07.24.
//

import UIKit

final class PokemonTypeView: UIView {
    // MARK: - Constants
    private enum Constants {
        static let pokemonTypeLabelFont: UIFont = .systemFont(ofSize: 16.0, weight: .regular)
        static let borderWidth: CGFloat = 1.0
    }
    
    struct PokemonType: Equatable {
        let typeName: String
        let typeIcon: String
        let color: String
    }
    
    private let pokemonTypeLabel = UILabel()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupItems()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = bounds.height / 2.0
    }
    
    // MARK: - Configure
    func configure(with pokemonType: PokemonType) {
        if pokemonType.typeName != "" {
            self.layer.borderColor = self.getBackgroundColor(type: pokemonType.color).cgColor
            self.pokemonTypeLabel.textColor = self.getBackgroundColor(type: pokemonType.color)
            guard let typeIcon = self.getCharacterForType(type: pokemonType.typeIcon) else { return }
            self.pokemonTypeLabel.text = String(typeIcon) + " " + pokemonType.typeName
        } else {
            self.layer.isHidden = true
        }
    }
}

extension PokemonTypeView {
    // MARK: - Private methods
    func setupItems() {
        self.layer.borderWidth = Constants.borderWidth
        self.layer.cornerRadius = bounds.height / 2.0
        
        setupPokemonTypeLabel()
    }
    
    func setupPokemonTypeLabel() {
        addSubview(pokemonTypeLabel)
        pokemonTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        pokemonTypeLabel.font = Constants.pokemonTypeLabelFont
        
        
        NSLayoutConstraint.activate([
            pokemonTypeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5.0),
            pokemonTypeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0),
            pokemonTypeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0),
            pokemonTypeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            pokemonTypeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5.0),
        ])
    }
    
    func getBackgroundColor(type: String) -> UIColor {
        switch type {
        case "grass":
            return .systemGreen
        case "poison":
            return .lightGray
        case "bug":
            return .systemOrange
        case "fire":
            return .systemRed
        case "flying":
            return .cyan
        case "water":
            return .systemBlue
        case "fairy":
            return .systemPink
        case "ground":
            return .systemBrown
        case "rock":
            return .brown
        case "fighting":
            return .systemRed
        case "psychic":
            return .systemIndigo
        case "electric":
            return .cyan
        case "steel":
            return .lightGray
        case "dark":
            return .darkGray
        case "dragon":
            return .red
        default:
            return .systemTeal
        }
    }
    
    func getCharacterForType(type: String) -> Character? {
        switch type {
        case "grass":
            return "🌱"
        case "poison":
            return "🧪"
        case "bug":
            return "🐞"
        case "fire":
            return "🔥"
        case "flying":
            return "🦋"
        case "water":
            return "💦"
        case "fairy":
            return "🦄"
        case "ground":
            return "🍃"
        case "rock":
            return "🪨"
        case "fighting":
            return "⚔️"
        case "psychic":
            return "🔮"
        case "electric":
            return "⚡️"
        case "steel":
            return "⛓️"
        case "dark":
            return "▓"
        case "dragon":
            return "🐲"
        case "normal":
            return "💎"
        default:
            return nil
        }
    }
}



