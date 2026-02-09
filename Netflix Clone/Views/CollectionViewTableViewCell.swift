//
//  CollectionViewTableViewCell.swift
//  Netflix Clone
//
//  Created by Memo Figueredo on 26/1/26.
//

import UIKit

protocol CollectionViewTableViewCellDelegate: AnyObject {
  func CollectionViewTableViewCellDipTapCell(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel)
}

class CollectionViewTableViewCell: UITableViewCell {

  static let identifier = "CollectionViewTableViewCell"
  
  weak var delegate: CollectionViewTableViewCellDelegate?
  
  private var titles: [Title] = []
  
  //esta es la collectionView de los posters de topTrending, popular, etc.
  private let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: 140, height: 200)
    layout.scrollDirection = .horizontal
    //registra la celda
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
    return collectionView
  }()
  
  
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.backgroundColor = .systemPink
    contentView.addSubview(collectionView)
    
    collectionView.delegate = self
    collectionView.dataSource = self
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    collectionView.frame = contentView.bounds
  }
  
  public func configure(with titles: [Title]) {
    self.titles = titles
    DispatchQueue.main.async { [weak self] in
      self?.collectionView.reloadData()
    }
  }
  
}


extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
      return UICollectionViewCell()
    }
    //desempaquetamos la ruta de la imagen que es un opcional en el modelo
    guard let model = titles[indexPath.row].poster_path else {
      return UICollectionViewCell()
    }
    //accdemos al metodo configure del TitleCollecitonViewCell y le pasamos el modelo del poster_path
    cell.configure(with: model)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return titles.count
  }
  
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: true)
    
    //obtiene la pelicula correcta
    let title = titles[indexPath.row]
    //obtiene el nombre de la movie
    guard let titleName = title.original_title ?? title.original_name else {
      return
    }
    //pedimos el trailer a la API, se busca el trailer en youtube
    APICaller.shared.getMovie(with: titleName + " trailer") { [weak self] result in
      switch result {
      case .success(let videoElement)://-->si la api funciona bien, se obtiene el trailer correcto
        
        //se obtiene la descripción de la movie, se saca un resumen.
        let title = self?.titles[indexPath.row]
        guard let titleOverview = title?.overview else {
          return
        }
        //se asegura de que self (celda de la UICollectionView) exista, para evitar que crashee si la vista ya no existe. si la celda
        guard let strongSelf = self else {
          return
        }
        //se crea un viewModel, empaquetando toda la info necesaria para la siguiente pantalla
        let viewModel = TitlePreviewViewModel(title: titleName, youtubeView: videoElement, titleOverview: titleOverview)
        //=====================================================================================================
        
        /*
         se avisa al delegado lo siguiente:
         👉 Básicamente dice:

         “Oye, tocaron esta película, aquí están sus datos, abre la pantalla de detalle”

         El delegado (normalmente un ViewController) se encarga de:

         + Navegar

         + Mostrar el preview

         + Reproducir el trailer
         */
        self?.delegate?.CollectionViewTableViewCellDipTapCell(strongSelf, viewModel: viewModel)
        
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
    
  }
  
  
}
