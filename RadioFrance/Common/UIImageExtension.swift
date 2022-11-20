//
//  Extension.swift
//  RadioFrance
//
//  Created by Loic D on 15/11/2022.
//

import Foundation
import SwiftUI

extension UIImage {
    
    /* Retourne un gradient
        Le gradien est composé de deux couleurs :
        - la couleur moyenne de l'image
        - cette même couleur légèrement plus sombre
     
        Retourne un gradient noir si une erreur se produit
     */
    var averageColorGradient: Gradient {
        // default gradient to return in case of error
        let defaultGradient = Gradient(colors: [.black, .black])
        
        guard let inputImage = CIImage(image: self) else { return defaultGradient }

        let extentVector = CIVector(x: inputImage.extent.origin.x,
                                    y: inputImage.extent.origin.y,
                                    z: inputImage.extent.size.width,
                                    w: inputImage.extent.size.height)

        guard let filter = CIFilter(name: "CIAreaAverage",
                                  parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return defaultGradient }
        guard let outputImage = filter.outputImage else { return defaultGradient }

        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull!])

        context.render(outputImage,
                       toBitmap: &bitmap,
                       rowBytes: 4,
                       bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
                       format: .RGBA8,
                       colorSpace: nil)

        let averageUiColor = UIColor(red: CGFloat(bitmap[0]) / 255,
                              green: CGFloat(bitmap[1]) / 255,
                              blue: CGFloat(bitmap[2]) / 255,
                              alpha: CGFloat(bitmap[3]) / 255)
        
        let darkCoefficient = 0.8
        let darkerUiColor = UIColor(red: CGFloat(bitmap[0]) / 255 * darkCoefficient,
                                    green: CGFloat(bitmap[1]) / 255 * darkCoefficient,
                                    blue: CGFloat(bitmap[2]) / 255 * darkCoefficient,
                                    alpha: CGFloat(bitmap[3]) / 255)
        
        return Gradient(colors: [Color(averageUiColor), Color(darkerUiColor)])
    }
}
