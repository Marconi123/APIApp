//
//  DetailedUserVC.swift
//  APIApp
//
//  Created by Владислав on 7.09.22.
//

import UIKit

final class DetailedUserVC: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var phoneLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var streetLabel: UILabel!
    @IBOutlet private weak var suiteLabel: UILabel!
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var zipcodeLabel: UILabel!
    @IBOutlet private weak var latLabel: UILabel!
    @IBOutlet private weak var lngLabel: UILabel!
    @IBOutlet private weak var nameCompanyLabel: UILabel!
    @IBOutlet private weak var catchPhraseLabel: UILabel!
    @IBOutlet private weak var bsLabel: UILabel!
    @IBOutlet private weak var scrollView: UIScrollView!
    
    // MARK: - Properties
    
    var sendUser: User?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Actions
    
    @IBAction func todosActionBtn() {
        let storyboard = UIStoryboard(name: "ToDoSView", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TodosTVC") as! TodosTVC
        vc.user = sendUser
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func photosActionBtn() {
        let storyboard = UIStoryboard(name: "AlbumsView", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AlbumsTVC") as! AlbumsTVC
        vc.user = sendUser
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func postsActionBtn() {
        let storyboard = UIStoryboard(name: "PostsView", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PostsTVC") as! PostsTVC
        vc.user = sendUser
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func getLocationBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "LocationView", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "Location") as! LocationVC
        vc.user = sendUser
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Functions
    
    private func setupUI() {
        idLabel.text = String(sendUser?.id ?? 0)
        nameLabel.text = sendUser?.name
        usernameLabel.text = sendUser!.username
        phoneLabel.text = sendUser?.phone
        emailLabel.text = sendUser?.email
        cityLabel.text = sendUser?.address?.city
        suiteLabel.text = sendUser?.address?.suite
        streetLabel.text = sendUser?.address?.street
        zipcodeLabel.text = sendUser?.address?.zipcode
        latLabel.text = sendUser?.address?.geo?.lat
        lngLabel.text = sendUser?.address?.geo?.lng
        nameCompanyLabel.text = sendUser?.company?.name
        catchPhraseLabel.text = sendUser?.company?.catchPhrase
        bsLabel.text = sendUser?.company?.bs
    }

}
