//
//  DetailViewController.swift
//  DragonBallPro
//
//  Created by Jose Bueno Cruz on 21/3/24.
//

import UIKit
import Combine
import Kingfisher

final class DetailViewController: UIViewController {
    
    private var viewModel: DetailViewModel
    private var suscriptors = Set<AnyCancellable>()
    private var transformations: [Transformation] = []
    
    //MARK: - IBOutlets
    @IBOutlet weak var lblNameHero: UILabel!
    @IBOutlet weak var imageHero: UIImageView!
    @IBOutlet weak var txtDescriptionHero: UITextView!
    @IBOutlet weak var viewTransformations: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblTransformations: UILabel!
    
    //MARK: - Inits
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        debugPrint("Detail released")
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        binding()
        configUI()
    }
}

//MARK: - Binding ViewModel
extension DetailViewController {
    private func binding() {
        self.viewModel.$transformations
            .receive(on: DispatchQueue.main)
            .sink { [weak self] transformations in
                self?.transformations = transformations
                self?.collectionView.reloadData()
            }
            .store(in: &suscriptors)
        
        self.viewModel.$transformationsisEmpty
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.viewTransformations.isHidden = $0
            }
            .store(in: &suscriptors)
    }
}

//MARK: - CollectionView
extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return transformations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TransformationCell.reuseIdentifier, for: indexPath) as! TransformationCell
        cell.configCell(transformation: transformations[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewModel = DetailTransformationViewModel(transformation: transformations[indexPath.row])
        let nextVC = DetailTransformationViewController(viewModel: viewModel)
        let sheet = nextVC.sheetPresentationController
        sheet?.detents = [.medium(), .large()]
        self.present (nextVC, animated: true)
    }
}

//MARK: ConfigUI
extension DetailViewController {
    
    private func configUI() {
        registerCell()
        layoutCollectionView()
        configButtonLocations()
        internationalization()
    }
    // Registro de celda
    private func registerCell() {
        collectionView.register(UINib(nibName: TransformationCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: TransformationCell.reuseIdentifier)
        lblNameHero.text = viewModel.hero.name
        guard let imageURL = URL(string: viewModel.hero.photo ?? "") else {return}
        imageHero.kf.setImage(with: imageURL, options:  [.transition(.fade(0.2))])
        txtDescriptionHero.text = viewModel.hero.description
    }
    // Layout del collectionVIew
    private func layoutCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 300, height: 180)
        collectionView.collectionViewLayout = layout
    }
    // Configuración botón de navegación hasta las localizaciones
    private func configButtonLocations() {
        let imageButton = UIImage(named: "GPS")
        let newSize = CGSize(width: 60, height: 50)
        let resizedImage = imageButton?.resized(to: newSize)
        let locationsButton = UIButton(type: .custom)
        locationsButton.setImage(resizedImage, for: .normal)
        locationsButton.addTarget(self, action: #selector(navigateToLocations), for: .touchUpInside)
        let locationsBarBuoonItem = UIBarButtonItem(customView: locationsButton)
        navigationItem.rightBarButtonItem = locationsBarBuoonItem
    }
    // Internacionalización de los textos
    private func internationalization() {
        lblTransformations.text = NSLocalizedString("Transformations", comment: "text view controller transformations")
        navigationItem.title = NSLocalizedString("Detail", comment: "text title view controller")
    }
}

//MARK: Objc
extension DetailViewController {
    @objc func navigateToLocations() {
        let viewModel = LocationsViewModel(hero: viewModel.hero)
        let nextVC = LocationsViewController(viewModel: viewModel)
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
