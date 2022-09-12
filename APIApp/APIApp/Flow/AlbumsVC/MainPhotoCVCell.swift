//
//  MainPhotoCVCell.swift
//  APIApp
//
//  Created by Владислав on 11.09.22.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

final class MainPhotoCVCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var photoImage: UIImageView!

    // MARK: - Properties

    var photo: JSON!

    // MARK: - Functions

    func getThumbnail() {
        if let thumbnailURL = photo["thumbnailUrl"].string {
            if let image = CacheManager.shared.imageCache.image(withIdentifier: thumbnailURL) {
                photoImage.image = image
            } else {
                AF.request(thumbnailURL).responseImage { [weak self] response in
                    if case .success(let image) = response.result {
                        self?.photoImage.image = image
                        CacheManager.shared.imageCache.add(image, withIdentifier: thumbnailURL)
                    }
                }
            }
        }
    }
}
