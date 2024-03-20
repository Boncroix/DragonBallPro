//
//  CollectionViewCell.swift
//  DragonBallPro
//
//  Created by Jose Bueno Cruz on 19/3/24.
//

import UIKit
import Kingfisher

final class HeroViewCell: UICollectionViewCell {
    
    //MARK: - Identifier
    static var reuseIdentifier: String {
        return String(describing: self)
    }

    //MARK: - IBOutlets
    @IBOutlet weak var imageHero: UIImageView!
    @IBOutlet weak var lblNameHero: UILabel!
    
    //MARK: - ConfigCell
    func configCell(hero: Hero) {
        lblNameHero.text = hero.name
        guard let imageURL = URL(string: hero.photo ?? "") else {
            return
        }     
        imageHero.kf.setImage(with: imageURL, options:  [.transition(.fade(0.2))])
    }
}
