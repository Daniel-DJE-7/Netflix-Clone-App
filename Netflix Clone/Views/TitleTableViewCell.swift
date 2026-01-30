//
//  TitleTableViewCell.swift
//  Netflix Clone
//
//  Created by Memo Figueredo on 30/1/26.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

  static let identifier = "TitleTableViewCell"
  
  private let playTitleButton: UIButton = {
    let button = UIButton()
    let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
    button.setImage(image, for: .normal)
    button.tintColor = .white
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 2
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let titlesPosterUIImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.addSubview(titlesPosterUIImageView)
    contentView.addSubview(titleLabel)
    contentView.addSubview(playTitleButton)
    
    applyConstraints()
    
  }
  
  
  private func applyConstraints() {
    NSLayoutConstraint.activate([
      // constraints of titlesPosterUIImageView
      titlesPosterUIImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      titlesPosterUIImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      titlesPosterUIImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
      titlesPosterUIImageView.widthAnchor.constraint(equalToConstant: 100),
      
      //constraints of titleLabel
      titleLabel.leadingAnchor.constraint(equalTo: titlesPosterUIImageView.trailingAnchor, constant: 20),
      titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      
      //constraints of titleButton
      playTitleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      playTitleButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
    ])
  }
  
  
  //method to hold the poster and label
  public func configure(with model: TitleViewModel) {
    guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else {
      return
    }
    
    titlesPosterUIImageView.sd_setImage(with: url, completed: nil)
    titleLabel.text = model.titleName
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
