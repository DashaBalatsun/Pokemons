//
//  PokemonListTableViewCell.swift
//  Pokemons
//
//  Created by Дарья Балацун on 23.06.24.
//
import UIKit

final class PokemonListTableViewCell: UITableViewCell {
    static var cellID: String {String(describing: self)}
    
    //MARK: - Constants
    private enum Constants {
        static let containerViewCornerRadius: CGFloat = 20.0
        static let containerViewBorderWidth: CGFloat = 0.5
        static let containerViewLeadingOffset: CGFloat = 5.0
        static let containerViewBottomInset: CGFloat = -5.0
        static let containerViewTrailingInset: CGFloat = -5.0
        
        static let pokemonImageCornerRadius: CGFloat = 40.0
        static let pokemonImageLeadingOffset: CGFloat = 10.0
        static let pokemonImageWidht: CGFloat = 0.20
        static let pokemonImageHight: CGFloat = 0.78
        
        static let pokemonNameLabelFontSize: CGFloat = 20.0
        
        static let pokemonNameLabelTrailingInset: CGFloat = -10.0
        static let pokemonNameLabelLeadingOffset: CGFloat = 15.0
    }
    
    private let pokemonNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = UIFont.boldSystemFont(ofSize: Constants.pokemonNameLabelFontSize)
        lbl.textAlignment = NSTextAlignment.left
        return lbl
    }()
    
    private let pokemonGameIndexLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .darkGray
        lbl.font = .systemFont(ofSize: 16.0, weight: .regular)
        lbl.textAlignment = NSTextAlignment.left
        return lbl
    }()
    
    private let containerView = UIView()
    private let pokemonParametersStackView = UIStackView()
    private let backgroundPokemonView = UIView()
    
//    private let pokemonImage = ImageLoader()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupItems()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    func configure(model: PokemonListTableViewCellViewModel) {
        self.pokemonNameLabel.text = model.name
//        self.pokemonImage.loadImageFromURL(model.imageURL)
        self.pokemonGameIndexLabel.text = model.gameIndex
    }
}

private extension PokemonListTableViewCell {
    //MARK: - Private methods
    private func setupItems() {
        self.selectionStyle = .none
        self.backgroundColor = UIColor(
            red: 11/255,
            green: 17/255,
            blue: 36/255,
            alpha: 200/255
        )
        
        setupContainerView()
        setupBagroundPokemonView()
//        setupImageView()
        setupPokemonParametersStackView()
        setUpPokemonNameLabel()
    }
    
    func setupContainerView() {
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.borderWidth = Constants.containerViewBorderWidth
        containerView.layer.cornerRadius = Constants.containerViewCornerRadius
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.containerViewLeadingOffset),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.containerViewTrailingInset),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.containerViewBottomInset)
        ])
    }
    
    func setupBagroundPokemonView() {
        containerView.addSubview(backgroundPokemonView)
        backgroundPokemonView.translatesAutoresizingMaskIntoConstraints = false
        backgroundPokemonView.layer.cornerRadius = 30
        backgroundPokemonView.backgroundColor = UIColor(
            red: 20/255,
            green: 30/255,
            blue: 52/255,
            alpha: 1/1
        )
        
        NSLayoutConstraint.activate([
            backgroundPokemonView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.pokemonImageLeadingOffset),
            backgroundPokemonView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            backgroundPokemonView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.pokemonImageWidht),
            backgroundPokemonView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: Constants.pokemonImageHight)
        ])
    }
    
//    func setupImageView() {
//        backgroundPokemonView.addSubview(pokemonImage)
//        pokemonImage.translatesAutoresizingMaskIntoConstraints = false
//        pokemonImage.contentMode = .scaleAspectFit
//        pokemonImage.layer.cornerRadius = Constants.pokemonImageCornerRadius
//        pokemonImage.clipsToBounds = true
//        
//        
//        NSLayoutConstraint.activate([
//            pokemonImage.topAnchor.constraint(equalTo: backgroundPokemonView.topAnchor),
//            pokemonImage.leadingAnchor.constraint(equalTo: backgroundPokemonView.leadingAnchor),
//            pokemonImage.trailingAnchor.constraint(equalTo: backgroundPokemonView.trailingAnchor),
//            pokemonImage.bottomAnchor.constraint(equalTo: backgroundPokemonView.bottomAnchor)
//        ])
//    }
    
    func setupPokemonParametersStackView() {
        containerView.addSubview(pokemonParametersStackView)
        pokemonParametersStackView.translatesAutoresizingMaskIntoConstraints = false
        pokemonParametersStackView.axis = .vertical
        pokemonParametersStackView.distribution = .fillProportionally
        pokemonParametersStackView.alignment = .leading
        pokemonParametersStackView.spacing = 10.0
        
        pokemonParametersStackView.addArrangedSubview(pokemonNameLabel)
        pokemonParametersStackView.addArrangedSubview(pokemonGameIndexLabel)
        
        NSLayoutConstraint.activate([
            pokemonParametersStackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            pokemonParametersStackView.leadingAnchor.constraint(equalTo: backgroundPokemonView.trailingAnchor, constant: Constants.pokemonNameLabelLeadingOffset)
        ])
    }
    
    func setUpPokemonNameLabel() {
        containerView.addSubview(pokemonNameLabel)
        pokemonNameLabel.translatesAutoresizingMaskIntoConstraints = false
        pokemonNameLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        NSLayoutConstraint.activate([
            pokemonNameLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            pokemonNameLabel.leadingAnchor.constraint(equalTo: backgroundPokemonView.trailingAnchor, constant: Constants.pokemonNameLabelLeadingOffset),
            
        ])
    }
}

extension UIView {
    func addShimmer(_ view: UIView) {
        let white = UIColor.white.cgColor
        let alpha = UIColor.white.withAlphaComponent(0.75).cgColor
        
        let gradient = CAGradientLayer()
        gradient.colors = [alpha, white, alpha]
        gradient.locations = [0, 0.5, 1]
        gradient.frame = self.frame
        let angel = 45 * CGFloat.pi / 180
        gradient.transform = CATransform3DMakeRotation(angel, 0, 0, 1)
        view.layer.mask = gradient
        
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.fromValue = -view.frame.width
        animation.toValue = view.frame.width
        animation.duration = 1.25
        animation.repeatCount = .infinity
        gradient.add(animation, forKey: "someKey")
    }
}
