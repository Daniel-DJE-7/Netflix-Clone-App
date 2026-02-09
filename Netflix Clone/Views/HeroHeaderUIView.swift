//
//  HeroHeaderUIView.swift
//  Netflix Clone
//
//  Created by Memo Figueredo on 26/1/26.
//

import UIKit

class HeroHeaderUIView: UIView {

  
  private let downloadButton: UIButton = {
    let button = UIButton()
    button.setTitle("Download", for: .normal)
    button.layer.borderColor = UIColor.white.cgColor
    button.layer.borderWidth = 1
    button.layer.cornerRadius = 5
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  
  private let playButton: UIButton = {
    let button = UIButton()
    button.setTitle("Play", for: .normal)
    button.layer.borderColor = UIColor.white.cgColor
    button.layer.borderWidth = 1
    button.layer.cornerRadius = 5
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  
  private let heroImageView: UIImageView = {
    
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.image = UIImage(named: "david")
    return imageView
  }()
  
  //method to add dispeling to the image of David
  private func addGradient() {
    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = [
      UIColor.clear.cgColor,
      UIColor.systemBackground.cgColor
    ]
    gradientLayer.frame = bounds
    layer.addSublayer(gradientLayer)
  }
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(heroImageView)
    addGradient()
    addSubview(playButton)
    addSubview(downloadButton)

    
    applyConstraints()

  }
  
  
  func applyConstraints() {

//    let playButtonConstraints = [
//      playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 90),
//      playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
//      playButton.widthAnchor.constraint(equalToConstant: 100)
//    ]
//
//    let downloadButtonConstraints = [
//      downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -90),
//      downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
//      downloadButton.widthAnchor.constraint(equalToConstant: 100)
//    ]
//
//    NSLayoutConstraint.activate(playButtonConstraints)
//    NSLayoutConstraint.activate(downloadButtonConstraints)
    
    NSLayoutConstraint.activate([
    //playButtonConstraints
      playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 70),
      playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
      playButton.widthAnchor.constraint(equalToConstant: 120),
    //downloadbuttonContraints
      downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -70),
      downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
      downloadButton.widthAnchor.constraint(equalToConstant: 120)
    ])
  }
  
  //configurar aleatoriamente el poster del heroHeaderView
  public func configure(with model: TitleViewModel) {
    guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else {
      return
    }
    heroImageView.sd_setImage(with: url, completed: nil)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    heroImageView.frame = bounds
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
