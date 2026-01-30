//
//  HomeViewController.swift
//  Netflix Clone
//
//  Created by Memo Figueredo on 23/1/26.
//

import UIKit

enum Sections: Int {
  case TrendingMovies = 0
  case TrendingTv = 1
  case Popular = 2
  case Upcoming = 3
  case TopRadted = 4
  
}



class HomeViewController: UIViewController {

  //titles of each section
  let sectionTitles: [String] = ["Trending Movies", "Trending Tv", "Popular", "Upcoming Movies", "Top rated"]
  
  
  //crea el table view
  private let homeFoodTable: UITableView = {
    let table = UITableView(frame: .zero, style: .grouped)
    table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
    
    return table
  }()
  
  
    override func viewDidLoad() {
        super.viewDidLoad()

      view.backgroundColor = .systemBackground
      view.addSubview(homeFoodTable)
      
      homeFoodTable.delegate = self
      homeFoodTable.dataSource = self
      
      configuerNavBar()
      
      
      let headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
      homeFoodTable.tableHeaderView = headerView
    }
    
  
  //MARK: - CONFIGURATION OF NAVBAR
      private func configuerNavBar() {
        
//        var image = UIImage(named: "netflixLogo")
//        image = image?.withRenderingMode(.alwaysOriginal)
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
       // LEFT BAR BUTTON
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "netflixLogo")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit

        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 30)
        ])

//        button.addTarget(self, action: #selector(netflixTapped), for: .touchUpInside)

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        
        
        //RIGHT BAR BUTTON
        navigationItem.rightBarButtonItems = [
          UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
          UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        
        //CHANGING THE COLOR OF ICONS IN NAVBAR
        navigationController?.navigationBar.tintColor = .white
      }

//  @objc private func netflixTapped() {
//    print("it's working")
//  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    homeFoodTable.frame = view.bounds
  }
  
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return sectionTitles.count
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
      return UITableViewCell()
    }
    
    switch indexPath.section {
      case Sections.TrendingMovies.rawValue:
        APICaller.shared.getTrendingMovies { result in
          switch result {
            case .success(let titles):
              cell.configure(with: titles)
            case .failure(let error):
              print(error.localizedDescription)
          }
        }
      
      case Sections.TrendingTv.rawValue:
        APICaller.shared.getTrendingTvs { result in
          switch result {
            case .success(let titles):
              cell.configure(with: titles)
            case .failure(let error):
              print(error.localizedDescription)
          }
        }
      
      case Sections.Popular.rawValue:
        APICaller.shared.getPopular { result in
          switch result {
            case .success(let titles):
              cell.configure(with: titles)
            case .failure(let error):
              print(error.localizedDescription)
          }
        }
      
      case Sections.Upcoming.rawValue:
        APICaller.shared.getUpcomingMovies { result in
          switch result {
            case .success(let titles):
              cell.configure(with: titles)
            case .failure(let error):
              print(error.localizedDescription)
          }
        }
      
      case Sections.TopRadted.rawValue:
        APICaller.shared.getTopRated { result in
          switch result {
            case .success(let titles):
              cell.configure(with: titles)
            case .failure(let error):
              print(error)
          }
        }
    default:
      return UITableViewCell()
    }
    
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 200
  }
  
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 40
  }
  
  func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    guard let header = view as? UITableViewHeaderFooterView else { return }
    header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
    header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
    header.textLabel?.textColor = .white
    header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
  }
  
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return sectionTitles[section]//aqui retornamos un array de strings
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let defaultOffset = view.safeAreaInsets.top
    let offSet = scrollView.contentOffset.y + defaultOffset

    navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offSet))
  }
  
}
