//
//  PhotosTVC.swift
//  APIApp
//
//  Created by Владислав on 11.09.22.
//

import UIKit
import Alamofire
import SwiftyJSON

final class TodosTVC: UITableViewController {
    
    // MARK: - Properties
    
    var user: User?
    var todos: [todo] = []
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTodos()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todo = todos[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "todosCell", for: indexPath)
        cell.textLabel?.text = todo.title
        print(todos)
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation
    
    private func fetchTodos() {
        guard let userId = user?.id else {
            return
        }
        let pathUrl = "\(ApiConstants.todosPath)?userId=\(userId)"

        guard let url = URL(string: pathUrl) else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                return
            }
            do {
                self.todos = try JSONDecoder().decode([todo].self, from: data)
                print(self.todos)
            } catch {
                print(error)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        .resume()
    }
}
