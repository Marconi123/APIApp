//
//  PhotosCVC.swift
//  APIApp
//
//  Created by Владислав on 11.09.22.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

final class AlbumsTVC: UITableViewController {
    
    // MARK: - Properties
    
    var user:User?
    var albums:[JSON] = []
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    // MARK: - Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        albums.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumsCell", for: indexPath)
        cell.textLabel?.text = (albums[indexPath.row]["id"].int ?? 0).description
        cell.detailTextLabel?.text = albums[indexPath.row]["title"].stringValue
        cell.detailTextLabel?.numberOfLines = 0
        return cell
    }
    
    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let albom = albums[indexPath.row]
        performSegue(withIdentifier: "showPhotos", sender: albom)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhotos",
            let photosCollectionVC = segue.destination as? MainPhotoCVC,
            let album = sender as? JSON {
            photosCollectionVC.user = user
            photosCollectionVC.album = album
        }
    }

    
    // MARK: - Functions
    
    private func getData() {
        guard let userId = user?.id else { return }
        
        guard let url = URL(string: "\(ApiConstants.albumsPath)?userId=\(userId)") else { return }
        
        AF.request(url).responseJSON { response in
            switch response.result {
            case .success(let data):
                self.albums = JSON(data).arrayValue
                self.tableView.reloadData()
            case .failure(let err):
                print(err)
            }
        }
    }
}
