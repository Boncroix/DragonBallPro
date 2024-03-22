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
    
    //MARK: - Inits
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
                guard let self = self else { return }
                self.transformations = transformations
                self.viewTransformations.isHidden = self.viewModel.checkTransformations()
                self.collectionView.reloadData()
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
        /// Registro y configuración de celda
        collectionView.register(UINib(nibName: TransformationCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: TransformationCell.reuseIdentifier)
        lblNameHero.text = viewModel.hero.name
        guard let imageURL = URL(string: viewModel.hero.photo ?? "") else {return}
        imageHero.kf.setImage(with: imageURL, options:  [.transition(.fade(0.2))])
        txtDescriptionHero.text = viewModel.hero.description
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 300, height: 180)
        collectionView.collectionViewLayout = layout
    }
}
