//
//  HerosViewController.swift
//  DragonBallPro
//
//  Created by Jose Bueno Cruz on 16/3/24.
//

import UIKit
import Combine
import CombineCocoa

final class HerosViewController: UIViewController {
    
    private var appState: AppState
    private var viewModel: HeroesViewModel
    private var suscriptors = Set<AnyCancellable>()
    private var heroes: [Hero] = []
    private var searchText: String = ""
    
    //MARK: IBOutlets
    @IBOutlet weak var heroSearch: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Inits
    init(appState: AppState, viewModel: HeroesViewModel) {
        self.appState = appState
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
        configUI()
        binding()
        bindingUI()
    }
}

//MARK: - Binding ViewModel
 extension HerosViewController {
     private func binding() {
         self.viewModel.$heroes
             .receive(on: DispatchQueue.main)
             .sink { [weak self] _ in
                 self?.collectionView.reloadData()
             }
             .store(in: &suscriptors)
     }
 }

//MARK: - Binding UI
extension HerosViewController {
    private func bindingUI() {
        if let heroSearch = self.heroSearch {
            heroSearch.textDidChangePublisher
                .receive(on: DispatchQueue.main)
                .sink { [weak self] text in
                    self?.viewModel.filterHeroesBy(name: text)
                    self?.collectionView.reloadData()
                }
                .store(in: &suscriptors)
                }
        }
}

//MARK: - CollectionView
extension HerosViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.heroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeroViewCell.reuseIdentifier, 
                                                      for: indexPath) as! HeroViewCell
        cell.configCell(hero: viewModel.heroes[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewModel = DetailViewModel(hero: viewModel.heroes[indexPath.row])
        let nextVC = DetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

//MARK: - ConfigUI
extension HerosViewController {
    /// Configurar botón de logout y segmentControl para ordenar los heroes
    private func configUI() {
        /// SegmentedControl para ordenar herores
        navigationController?.navigationBar.tintColor = UIColor.blackAndWhite
        let segmentedControl = UISegmentedControl(items: ["A - Z", "Z - A"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)),
                                   for: .valueChanged)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: segmentedControl)
        /// Botón logout
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)
        let symbolImage = UIImage(systemName: "figure.walk.motion", withConfiguration: symbolConfiguration)
        let logoutButton = UIButton(type: .custom)
        logoutButton.setImage(symbolImage, for: .normal)
        logoutButton.addTarget(self, action: #selector(closeSession), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: logoutButton)
        navigationItem.rightBarButtonItem = barButton
        navigationItem.title = "HEROES"
        /// Registro y configuración de celda
        collectionView.register(UINib(nibName: HeroViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: HeroViewCell.reuseIdentifier)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 190, height: 190)
        collectionView.collectionViewLayout = layout
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        let ascending = sender.selectedSegmentIndex == 0 ? true : false
        viewModel.sortHeroesByName(ascending: ascending)
    }
    
    @objc func closeSession(){
        appState.closeSessionUser()
    }
}
