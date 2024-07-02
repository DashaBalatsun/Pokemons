//
//  PokemonDetailsView.swift
//  Pokemons
//
//  Created by Дарья Балацун on 2.07.24.
//

import UIKit

final class PokemonDetailsView: UIView {
    
    var imageView: ImageLoader = {
        let image = ImageLoader()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    var imageViewForBackground: ImageLoader = {
        let image = ImageLoader()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    var idPokemon: UILabel = {
        let id = UILabel()
        id.textColor = .white
        id.font = UIFont(name: "NoyhGeometricSlim-Black", size: 26.0)
        return id
    }()
    
    var namePokemonLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = NSTextAlignment.left
        nameLabel.numberOfLines = 0
        nameLabel.textColor = .white
        nameLabel.font = UIFont (name: "Helvetica Bold", size: 26.0)
        return nameLabel
    }()
    
    var typesPokemonLabel: UILabel = {
        let typesPokemonLabel = UILabel()
        typesPokemonLabel.textAlignment = NSTextAlignment.center
        typesPokemonLabel.textColor = .white
        let font: UIFont = .systemFont(ofSize: 18.0, weight: .regular)
        typesPokemonLabel.font = font
        return typesPokemonLabel
    }()
    
    let stackViewForTypes = UIStackView()
    let stackViewForParameters = UIStackView()
    
    let gradientColorView = UIView()
    let containerDetailsView = UIView()
    let pokemonTypeViewFirst = PokemonTypeView()
    let pokemonTypeViewSecond = PokemonTypeView()
    let parametersView = PokemonParametersView()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(
            red: 11/255,
            green: 17/255,
            blue: 36/255,
            alpha: 200/25
        )
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    } 
}

//MARK: - SetUp PokemonDetailsView
extension PokemonDetailsView {
    
    func setupViews() {
        setupIdPokemon()
        setupImageView()
        setupStackViewForParameters()
        setupStackViewForTypes()
        setupStackViewParameters()
    }
    
    func setupIdPokemon() {
        addSubview(idPokemon)
        idPokemon.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            idPokemon.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30.0),
            idPokemon.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    func setupImageView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        imageView.layer.shadowColor = UIColor.gray.cgColor
        imageView.layer.shadowOffset = CGSize(width: 0, height: 0)
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.shadowRadius = 80.0
        imageView.layer.masksToBounds = false
        
       
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: idPokemon.bottomAnchor, constant: 20.0),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
        ])
    }
    
    func setupImageViewForBackground() {
        addSubview(imageViewForBackground)
        imageViewForBackground.translatesAutoresizingMaskIntoConstraints = false
        imageViewForBackground.contentMode = .scaleAspectFit
        imageViewForBackground.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            imageViewForBackground.topAnchor.constraint(equalTo: bottomAnchor, constant: 20.0),
            imageViewForBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageViewForBackground.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageViewForBackground.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.35),
            imageViewForBackground.centerXAnchor.constraint(equalTo: centerXAnchor),
            
        ])
    }

    func setupStackViewForParameters() {
        addSubview(stackViewForParameters)
        stackViewForParameters.translatesAutoresizingMaskIntoConstraints = false
        stackViewForParameters.distribution = .equalCentering
        stackViewForParameters.axis = .vertical
        stackViewForParameters.distribution = .fillProportionally
        stackViewForParameters.alignment = .center
        stackViewForParameters.spacing = 25.0
        
        stackViewForParameters.addArrangedSubview(namePokemonLabel)
        stackViewForParameters.addArrangedSubview(typesPokemonLabel)
        stackViewForParameters.addArrangedSubview(stackViewForTypes)
        
        NSLayoutConstraint.activate([
            stackViewForParameters.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 60.0),
            stackViewForParameters.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func setupStackViewForTypes() {
        stackViewForParameters.addSubview(stackViewForTypes)
        stackViewForTypes.translatesAutoresizingMaskIntoConstraints = false
        stackViewForTypes.axis = .horizontal
        stackViewForTypes.distribution = .fillProportionally
        stackViewForTypes.alignment = .center
        stackViewForTypes.spacing = 15.0
        stackViewForTypes.addArrangedSubview(pokemonTypeViewFirst)
        stackViewForTypes.addArrangedSubview(pokemonTypeViewSecond)
    }
    
    func setupStackViewParameters() {
        addSubview(parametersView)
        parametersView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            parametersView.topAnchor.constraint(equalTo: stackViewForParameters.bottomAnchor, constant: 60.0),
            parametersView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0),
            parametersView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0),
            parametersView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.10)
        ])
    }
}
 