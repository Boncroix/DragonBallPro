//
//  HeroAnnotationView.swift
//  DragonBallPro
//
//  Created by Jose Bueno Cruz on 2/4/24.
//

import Foundation
import MapKit

//MARK: HeroAnnotationView
final class HeroAnnotationView: MKAnnotationView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    //MARK: Inits
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        centerOffset = CGPoint(x: 0, y: -frame.size.height / 2)
        canShowCallout = true
        configUI()
    }
    
    @available(*,unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - ConfigUI
    func configUI() {
        backgroundColor = .clear
        let image = UIImage.init(named: "bola_dragon")
        let view = UIImageView.init(image: image)
        view.frame = bounds
        addSubview(view)
    }
}
