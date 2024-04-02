//
//  HeroAnotation.swift
//  DragonBallPro
//
//  Created by Jose Bueno Cruz on 2/4/24.
//

import Foundation
import MapKit

//MARK: - HeroAnotation
final class HeroAnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var id: UUID?
    var date:String?
    
    init(coordinate: CLLocationCoordinate2D, title: String? = nil, id: UUID? = nil, date: String? = nil) {
        self.coordinate = coordinate
        self.title = title
        self.id = id
        self.date = date
    }
    
}
