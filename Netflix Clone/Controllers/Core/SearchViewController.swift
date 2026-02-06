//
//  SearchViewController.swift
//  Netflix Clone
//
//  Created by Memo Figueredo on 23/1/26.
//

import UIKit

class SearchViewController: UIViewController {

  private var titles: [Title] = []
  
  private let discoverTable: UITableView = {
    let table = UITableView()
    table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
    return table
  }()
  
  
  private let searchController: UISearchController = {
    let controller = UISearchController(searchResultsController: SearchResultsViewController())
    controller.searchBar.placeholder = "Search for Movie or a TV show"
    controller.searchBar.searchBarStyle = .minimal
    return controller
  }()
  
    override func viewDidLoad() {
        super.viewDidLoad()

      view.backgroundColor = .systemBackground
      title = "Search"
      navigationController?.navigationBar.prefersLargeTitles = true
      navigationController?.navigationItem.largeTitleDisplayMode = .always
      
      view.addSubview(discoverTable)
      
      discoverTable.delegate = self
      discoverTable.dataSource = self
      
      //adding the search bar to the view
      navigationItem.searchController = searchController
      navigationController?.navigationBar.tintColor = .white
      
      fetchDiscoverMovies()
      
      searchController.searchResultsUpdater = self
    }
  
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    discoverTable.frame = view.bounds
  }
  
  
  private func fetchDiscoverMovies() {
    APICaller.shared.getDiscoverMovies { [weak self] result in
      switch result {
        case .success(let titles):
          self?.titles = titles
          DispatchQueue.main.async {
            self?.discoverTable.reloadData()
          }
        case .failure(let error):
          print(error.localizedDescription)
      }
    }
  }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return titles.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {
      return UITableViewCell()
    }
    let title = titles[indexPath.row]
    let model = TitleViewModel(titleName: title.original_name ?? title.original_title ?? "Unknown name", posterURL: title.poster_path ?? "")
    cell.configure(with: model)
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 140
  }
}

extension SearchViewController: UISearchResultsUpdating {
  
  //=======
  func updateSearchResults(for searchController: UISearchController) {
    //obtenemos el texto de la barra de busqueda que el usario ingreso
    let searchBar = searchController.searchBar
    //nos aseguramos de que haya texto
    guard let query = searchBar.text,
          //quita los espacios de los extremos y verifica que el campo no este vacio, porque evita las busquedas sin ningun texto introducido
          !query.trimmingCharacters(in: .whitespaces).isEmpty,
          //se asegura que en el campo de texto se hayan introducido por lo menos 3 caracteres,de lo contrario no busca
            query.trimmingCharacters(in: .whitespaces).count >= 3,
          let resultsController = searchController.searchResultsController as? SearchResultsViewController else {
              return
    }
    
    APICaller.shared.search(with: query) { result in
      DispatchQueue.main.async {
        switch result {
          case .success(let titles):
            resultsController.titles = titles
            resultsController.searchResultsCollectionView.reloadData()
          case .failure(let error):
            print(error.localizedDescription)
        }
      }
    }
  }
}
