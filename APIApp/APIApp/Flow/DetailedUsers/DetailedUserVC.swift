//
//  DetailedUserVC.swift
//  APIApp
//
//  Created by Владислав on 4.09.22.
//

import UIKit

final class DetailedUserVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - IBoutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    var sendUser:User?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }

    // MARK: - Table View Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailedCell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        guard let user = sendUser else { return cell }
        navigationItem.title = user.name
        switch indexPath.row {
        case 0: cell.textLabel?.text = "Name: \(user.name ?? "Name")"
        case 1: cell.textLabel?.text = "Email: \(user.email ?? "Email")"
        case 2: cell.textLabel?.text = "Phone: \(user.phone ?? "Phone")"
        case 3: cell.textLabel?.text = "Username: \(user.username ?? "Username" )"
        case 4: cell.textLabel?.text = "Website: \(user.website ?? "Website")"
        case 5: cell.textLabel?.text = "City: \(user.address?.city ?? "City" );" + " " + "Street: \(user.address?.street ?? "Street" );" + " " + "Suite: \(user.address?.suite ?? "Suite" );" + " " + "Zipcode: \(user.address?.zipcode ?? "Zipcode")"
        case 6: cell.textLabel?.text = "Lat: \(user.address?.geo?.lat ?? "Lat");" + " " + "Lng: \(user.address?.geo?.lng ?? "Lng")"
        case 7: cell.textLabel?.text = "Company Name:\(user.company?.name ?? "Name");" + " " +  "BS:\(user.company?.bs ?? "BS" );" + " " +  "Catch Phrase: \(user.company?.catchPhrase ?? "Catch Phrase")"
        default:
            return cell
        }
        return cell
    }
}
