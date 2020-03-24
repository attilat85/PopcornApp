//
//  UIStackView+Clear.swift
//  PopcornApp
//
//  Created by Atti's Macbbok pro on 23/03/2020.
//

import UIKit

extension UIImage {

    // https://stackoverflow.com/questions/14523348/how-to-change-the-background-color-of-a-uibutton-while-its-highlighted
    static func with(color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()

        context?.setFillColor(color.cgColor)
        context?.fill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }
    
    /// resize the image  or returns the original
    /// for almost the all images I called this methods, because the images are too big and the layout will be messed up
    func resizeImage(size: CGSize) -> UIImage {
        let imageSize = self.size

        let widthRatio  = size.width  / imageSize.width
        let heightRatio = size.height / imageSize.height

        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: imageSize.width * heightRatio, height: imageSize.height * heightRatio)
        } else {
            newSize = CGSize(width: imageSize.width * widthRatio, height: imageSize.height * widthRatio)
        }

        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage ?? self
    }
}
