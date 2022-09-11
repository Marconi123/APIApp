//
//  MainCVC.swift
//  APIApp
//
//  Created by Владислав on 31.08.22.
//

import UIKit


// MARK: - Enums

enum Actions: String, CaseIterable {
    case downloadImage = "Download Image"
    case users = "Users"
}

final class MainCVController: UICollectionViewController {
    
    // MARK: - Properties
    
    private let reuseIdentifier = "MainViewCell"
    private let action = Actions.allCases

    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        action.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MainCVCell
        cell.labelViewCell.text = action[indexPath.row].rawValue
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let action = action[indexPath.row]
        switch action {
        case .downloadImage: performSegue(withIdentifier: "ImageViewSegue",
                                          sender: nil)
        case .users: performSegue(withIdentifier: "UsersViewSegue",
                                  sender: nil)
        }
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? UsersTBC else { return }
        destinationVC.fetchUsers()
    }
}

extension MainCVController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 20
        return CGSize(width: (width), height: width / 2)
    }
}
