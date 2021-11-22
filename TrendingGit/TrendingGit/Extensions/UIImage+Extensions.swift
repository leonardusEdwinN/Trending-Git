//
//  UIImage+Extensions.swift
//  TrendingGit
//
//  Created by Edwin Niwarlangga on 20/11/21.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(withUrl url: URL) {
           DispatchQueue.global().async { [weak self] in
               if let imageData = try? Data(contentsOf: url) {
                   if let image = UIImage(data: imageData) {
                       DispatchQueue.main.async {
                           self?.image = image
                       }
                   }
               }
           }
       }
}
