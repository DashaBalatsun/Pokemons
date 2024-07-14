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
        static let parameterLabelFont = UIFont(name: "NoyhGeometricSlim-Black", size: 23.0)
        static let nameForParameterLabelFont: UIFont = .systemFont(ofSize: 18.0, weight: .regular)
    }
    
    struct PokemonViewForParametersModel {
        let parameter: Int?
        let parameterName: String?
        let unit: String?
        let parameterImage: UIImage?
    }
    
    private let parameterLabel = UILabel()
    private let nameForParameters = UILabel()
    private let parametersNameStackView = UIStackView()
    private let containerView = UIView()
    private let parametersStackView = UIStackView()
    private var parameterImage = UIImageView()
    
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
              let unit = model.unit,
              let image = model.parameterImage else {
            return
        }
        self.parameterLabel.text = String(Float(parameter)/10) + " " + unit
        self.nameForParameters.text = parameterName
        self.parameterImage.image = image
        if nameForParameters.text == "Height" {
            parameterImage.transform = CGAffineTransform(rotationAngle: .pi / 2)
        }
    }
    
}

extension PokemonViewForParameters {
    //    MARK: - Private methods
    func setupItems() {
        setupContainerView()
        setupParametersNameStackView()
        setupParametersStackView()
        setupParametrsLabel()
        setupNameForParameter()
        setupParameterImage()
    }
    
    func setupContainerView() {
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(parameterLabel)
        parameterLabel.translatesAutoresizingMaskIntoConstraints = false
    
        NSLayoutConstraint.activate([
            parameterLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 6.0),
            parameterLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            parameterLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            parameterLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
    
    func setupParametersNameStackView() {
        addSubview(parametersNameStackView)
        parametersNameStackView.translatesAutoresizingMaskIntoConstraints = false
        parametersNameStackView.axis = .horizontal
        parametersNameStackView.spacing = 10
        parametersNameStackView.distribution = .equalCentering
        
        parametersNameStackView.addArrangedSubview(parameterImage)
        parametersNameStackView.addArrangedSubview(containerView)
    }
    
    func setupParametersStackView() {
        addSubview(parametersStackView)
        parametersStackView.translatesAutoresizingMaskIntoConstraints = false
        parametersStackView.axis = .vertical
        parametersStackView.spacing = 10
        parametersStackView.alignment = .center
        
        parametersStackView.addArrangedSubview(nameForParameters)
        parametersStackView.addArrangedSubview(parametersNameStackView)
        
        NSLayoutConstraint.activate([
            parametersStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10.0),
            parametersStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            parametersStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10.0)
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

    func setupParameterImage() {
        parameterImage.tintColor = UIColor(white: 1, alpha: 0.8)
        
        NSLayoutConstraint.activate([
            parameterImage.widthAnchor.constraint(equalToConstant: 25),
            parameterImage.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
}

