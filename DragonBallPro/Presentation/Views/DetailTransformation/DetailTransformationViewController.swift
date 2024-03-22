//
//  DetailTransformationViewController.swift
//  DragonBallPro
//
//  Created by Jose Bueno Cruz on 21/3/24.
//

import UIKit
import Kingfisher

final class DetailTransformationViewController: UIViewController {
    
    private var viewModel: DetailTransformationViewModel

    //MARK: - IBOutlets
    @IBOutlet weak var nameTransformation: UILabel!
    @IBOutlet weak var imageTransformation: UIImageView!
    @IBOutlet weak var descriptionTransformation: UITextView!
    
    //MARK: - Inits
    init(viewModel: DetailTransformationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
}

//MARK: - ConfigUI
extension DetailTransformationViewController {
    private func configUI() {
        nameTransformation.text = viewModel.transformation.name
        descriptionTransformation.text = viewModel.transformation.description
        guard let imageURL = URL(string: viewModel.transformation.photo ?? "") else {return}
        imageTransformation.kf.setImage(with: imageURL, options:  [.transition(.fade(0.2))])
    }
}
