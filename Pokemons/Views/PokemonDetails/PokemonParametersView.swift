//
//  PokemonParametersView.swift
//  Pokemons
//
//  Created by Дарья Балацун on 2.07.24.
//

import UIKit

final class PokemonParametersView: UIView {
    
    struct PokemonParametersViewModel {
        let heightParameter: PokemonViewForParameters.PokemonViewForParametersModel
        let weightParameter: PokemonViewForParameters.PokemonViewForParametersModel
    }
    
    private let weightView = PokemonViewForParameters()
    private let heightView = PokemonViewForParameters()
    private let parametersStackView = UIStackView()
    private let gradientLayer = CAGradientLayer()
    private let verticalStick = UIView()
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupItems()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = bounds.height / 4
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = bounds.height / 4
    }
    
    // MARK: - Configure
    func configure(with model: PokemonParametersViewModel) {
        let weightParameter = model.weightParameter
        let heightParameter = model.heightParameter
        weightView.configure(with: weightParameter)
        heightView.configure(with: heightParameter)
    }
}

extension PokemonParametersView {
    // MARK: - Private Methods
    func setupItems() {
        setupGradient()
        setupParametersStackView()
        setupVerticalStick()
    }
    
    func setupParametersStackView() {
        addSubview(parametersStackView)
        parametersStackView.translatesAutoresizingMaskIntoConstraints = false
        parametersStackView.axis = .horizontal
        parametersStackView.distribution = .fillProportionally
        parametersStackView.alignment = .center
        parametersStackView.spacing = 15.0
        parametersStackView.addArrangedSubview(weightView)
        parametersStackView.addArrangedSubview(verticalStick)
        parametersStackView.addArrangedSubview(heightView)
        
        
        
        NSLayoutConstraint.activate([
            parametersStackView.topAnchor.constraint(equalTo: topAnchor),
            parametersStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15.0),
            parametersStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15.0),
            parametersStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupVerticalStick() {
        addSubview(verticalStick)
        verticalStick.translatesAutoresizingMaskIntoConstraints = false
        verticalStick.backgroundColor = .gray
        
        NSLayoutConstraint.activate([
            verticalStick.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
            verticalStick.centerXAnchor.constraint(equalTo: centerXAnchor),
            verticalStick.centerYAnchor.constraint(equalTo: centerYAnchor),
            verticalStick.widthAnchor.constraint(equalToConstant: 1.0)
        ])
    }
    
    func setupGradient() {
        self.layer.addSublayer(gradientLayer)
        gradientLayer.colors = [
            UIColor(
            red: 20/255,
            green: 30/255,
            blue: 62/255,
            alpha: 0.5/1
        ).cgColor,
            UIColor(
            red: 11/255,
            green: 17/255,
            blue: 20/255,
            alpha: 1/1
        ).cgColor]
    }
}

