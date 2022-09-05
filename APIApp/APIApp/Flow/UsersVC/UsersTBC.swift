//
//  UsersTBC.swift
//  APIApp
//
//  Created by Владислав on 31.08.22.
//

import UIKit

final class UsersTBC: UITableViewController {
    
    // MARK: - Properties

    var users: [User] = []

    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        cell.detailTextLabel?.text = users[indexPath.row].phone

        return cell
    }
    
    // Functions
    
    func fetchUsers() {
        guard let url = URL(string: ApiConstants.usersPath) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in

            if let error = error {
                print(error)
            }

            guard let data = data else { return }

            do {
                self?.users = try JSONDecoder().decode([User].self, from: data)
            } catch {
                print(error)
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        .resume()
    }
    
    // MARK: - Nagigation
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailedViewSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? DetailedUserVC else { return }
        let selectedIndexPath =  tableView.indexPathForSelectedRow
        destinationVC.sendUser = users[selectedIndexPath!.row]
    
    }
}
