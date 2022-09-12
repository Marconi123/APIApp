//
//  MainPhotoCVC.swift
//  APIApp
//
//  Created by Владислав on 11.09.22.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

final class MainPhotoCVC: UICollectionViewController {
    
    // MARK: - Properties

    private let reuseIdentifier = "mainPhotoCell"

    var user: User!
    var album: JSON!
    var photos: [JSON] = []

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = album["title"].string
        getData()
    }

    override func viewWillAppear(_ animated: Bool) {
        let layout = UICollectionViewFlowLayout()
        let sizeWH = UIScreen.main.bounds.width / 2 - 5
        layout.itemSize = CGSize(width: sizeWH, height: sizeWH)
        collectionView.collectionViewLayout = layout
    }
    
    // MARK: Functions
    
    func getData() {
        if let album = album,
            let albumId = album["id"].int,
            let url = URL(string: "https://jsonplaceholder.typicode.com/photos?albumId=\(albumId)") {

            AF.request(url).responseJSON { response in
                switch response.result {
                case .success(let data):
                    self.photos = JSON(data).arrayValue
                    self.collectionView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

    // MARK: - UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainPhotoCell", for: indexPath) as! MainPhotoCVCell
        cell.photo = photos[indexPath.row]
        cell.getThumbnail()
        return cell
    }

    // MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToPhotoVC", sender: photos[indexPath.row])
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let photoVC = segue.destination as? PhotoVC,
           let photo = sender as? JSON {
            photoVC.photo = photo
        }
    }
}
