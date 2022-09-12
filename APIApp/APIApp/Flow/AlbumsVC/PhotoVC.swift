//
//  MainPhotoVC.swift
//  APIApp
//
//  Created by Владислав on 11.09.22.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class PhotoVC: UIViewController {
    
    // MARK: - IBOutlets

    @IBOutlet private weak var imageLabel: UIImageView!
    
    // MARK: - Properties
    
    var photo:JSON!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPhoto()
    }
    
    // MARK: - Functions
    
    func getPhoto() {
        if let photoURL = photo["url"].string {
            if let image = CacheManager.shared.imageCache.image(withIdentifier: photoURL) {
                imageLabel.image = image
            } else {
                AF.request(photoURL).responseImage { [weak self] response in
                    if case .success(let image) = response.result {
                        self?.imageLabel.image = image
                        CacheManager.shared.imageCache.add(image, withIdentifier: photoURL)
                    }
                }
            }
        }
    }

}
