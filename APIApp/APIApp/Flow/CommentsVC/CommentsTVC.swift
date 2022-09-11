//
//  CommentsTVC.swift
//  APIApp
//
//  Created by Владислав on 11.09.22.
//

import UIKit

final class CommentsTVC: UITableViewController {
    // MARK: - Properties

    var postID:Int?
    var comments: [Comment] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchComments()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comments.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comment = comments[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath)
        cell.textLabel?.text = "Title:" + " " +  "\(comment.name ?? "Not found")"
        cell.detailTextLabel?.text = "Message:" + " " + "\(comment.body ?? "Not found")"
        return cell
    }

    // MARK: - Actions

    func fetchComments() {
        guard let postId = postID else {
            return
        }
        let pathUrl = "\(ApiConstants.commentsPath)?postId=\(postId)"
        guard let url = URL(string: pathUrl) else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                return
            }
            do {
                self.comments = try JSONDecoder().decode([Comment].self, from: data)
                print(self.comments)
            } catch {
                print(error)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        task.resume()
    }
}
