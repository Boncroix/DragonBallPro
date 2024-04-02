//
//  TransformationCell.swift
//  DragonBallPro
//
//  Created by Jose Bueno Cruz on 21/3/24.
//

import UIKit
import Kingfisher

final class TransformationCell: UICollectionViewCell {

    //MARK: - Identifier
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    //MARK: - IBOutlets
    @IBOutlet weak var transformationLabel: UILabel!
    @IBOutlet weak var transformationImage: UIImageView!
    
    //MARK: - Configure
    func configCell(transformation: Transformation) {
        transformationLabel.text = transformation.name
        guard let imageURL = URL(string: transformation.photo ?? "") else {return}
        transformationImage.kf.setImage(with: imageURL, options:  [.transition(.fade(0.2))])
    }

}
