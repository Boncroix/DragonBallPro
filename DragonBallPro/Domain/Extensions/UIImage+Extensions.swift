//
//  UIImage+Extensions.swift
//  DragonBallPro
//
//  Created by Jose Bueno Cruz on 31/3/24.
//

import UIKit

extension UIImage {
    func resized(to newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        self.draw(in: CGRect(origin: .zero, size: newSize))
        guard let resizedImage = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        return resizedImage
    }
}
