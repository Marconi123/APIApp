//
//  PhotosTVC.swift
//  APIApp
//
//  Created by Владислав on 11.09.22.
//

import Alamofire
import SwiftyJSON
import UIKit

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
