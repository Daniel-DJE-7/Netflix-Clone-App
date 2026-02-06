//
//  TitlePreviewViewController.swift
//  Netflix Clone
//
//  Created by Memo Figueredo on 4/2/26.
//

import UIKit
import WebKit

class TitlePreviewViewController: UIViewController {

  private let titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 22, weight: .bold)
    label.text = "Avengers"
    return label
  }()
  
  private let overviewLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 18, weight: .regular)
    label.numberOfLines = 0
    label.text = "This is the best movie ever to watch as a kid"
    return label
  }()
  
  private let downloadButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.backgroundColor = .red
    button.setTitle("Download", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.layer.cornerRadius = 20
    button.layer.masksToBounds = true
    return button
  }()
  
  private let webView: WKWebView = {
      let config = WKWebViewConfiguration()
      config.allowsInlineMediaPlayback = true
      let webView = WKWebView(frame: .zero, configuration: config)
      webView.translatesAutoresizingMaskIntoConstraints = false
      return webView
  }()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      view.backgroundColor = .systemBackground
      
      view.addSubview(webView)
      view.addSubview(titleLabel)
      view.addSubview(overviewLabel)
      view.addSubview(downloadButton)
      
      configureConstraints()
      //ocultar el boton de atras
//      navigationItem.setHidesBackButton(true, animated: true)
      
    }
    
  func configureConstraints() {
    
    NSLayoutConstraint.activate([
    //webView Constraints
      webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 65),
      webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      webView.heightAnchor.constraint(equalToConstant: 300),
      //titleLabel Constraints
      titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
      titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      //overviewLabel Constraints
      overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
      overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      //downloadButton Constraints
      downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      downloadButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 25),
      downloadButton.widthAnchor.constraint(equalToConstant: 140),
      downloadButton.heightAnchor.constraint(equalToConstant: 40)
    ])
  }
  
  //revisar este codigo
  func configure(with model: TitlePreviewViewModel) {
    titleLabel.text = model.title
    overviewLabel.text = model.titleOverview
    
    let videoID = model.youtubeView.id.videoId//--> aqui está el error
    guard let url = URL(string: "https://www.youtube.com/embed/?playsinline=1")
    else {
      print("invalid url")
      return
    }
    print(url)
    webView.load(URLRequest(url: url))
  }
  
}

//url  Foundation.URL  "https://www.youtube.com/watch?v=BjkIOU5PhyQ?playsinline=1"
