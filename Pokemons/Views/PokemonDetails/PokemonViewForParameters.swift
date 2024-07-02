//
//  PokemonViewForParameters.swift
//  Pokemons
//
//  Created by Дарья Балацун on 2.07.24.
//

import UIKit

final class PokemonViewForParameters: UIView {
    // MARK: - Constants
    private enum Constants {
        static let parameterLabelFont = UIFont(name: "NoyhGeometricSlim-Black", size: 22.0)
        static let nameForParameterLabelFont: UIFont = .systemFont(ofSize: 18.0, weight: .regular)
    }
    
    struct PokemonViewForParametersModel {
        let parameter: Int?
        let parameterName: String?
        let symbol: Character?
        let unit: String?
    }
    
    private let parameterLabel = UILabel()
    private let nameForParameters = UILabel()
    private let parametersNameStackView = UIStackView()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupItems()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK: - Configure
    func configure(with model: PokemonViewForParametersModel) {
        guard let parameter = model.parameter,
              let parameterName = model.parameterName,
              let symbol = model.symbol,
              let unit = model.unit else {
            return
        }
        self.parameterLabel.text = String(symbol) + "   " + String(Float(parameter)/10) + " " + unit
        self.nameForParameters.text = parameterName
    }
    
}

extension PokemonViewForParameters {
    //    MARK: - Private methods
    func setupItems() {
        setupParametersNameStackView()
        setupParametrsLabel()
        setupNameForParameter()
    }
    
    func setupParametersNameStackView() {
        addSubview(parametersNameStackView)
        parametersNameStackView.translatesAutoresizingMaskIntoConstraints = false
        parametersNameStackView.axis = .vertical
        parametersNameStackView.spacing = 0.5
        parametersNameStackView.distribution = .fillEqually
        parametersNameStackView.alignment = .center
        
        parametersNameStackView.addArrangedSubview(parameterLabel)
        parametersNameStackView.addArrangedSubview(nameForParameters)
        
        NSLayoutConstraint.activate([
            parametersNameStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10.0),
            parametersNameStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            parametersNameStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10.0)
        ])
        
    }
    
    func setupParametrsLabel() {
        parameterLabel.font = Constants.parameterLabelFont
        parameterLabel.textColor = UIColor(white: 1, alpha: 0.8)
    }

    func setupNameForParameter() {
        nameForParameters.font = Constants.nameForParameterLabelFont
        nameForParameters.textColor = .darkGray
    }
}

