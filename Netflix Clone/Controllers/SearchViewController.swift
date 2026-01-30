//
//  SearchViewController.swift
//  Netflix Clone
//
//  Created by Memo Figueredo on 23/1/26.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

      view.backgroundColor = .systemBackground
      title = "Top Search"
      navigationController?.navigationBar.prefersLargeTitles = true
      navigationController?.navigationItem.largeTitleDisplayMode = .always
      
    }
    



}
