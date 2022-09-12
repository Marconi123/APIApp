//
//  PostsTVC.swift
//  APIApp
//
//  Created by Владислав on 4.09.22.
//

import Alamofire
import SwiftyJSON
import UIKit

final class PostsTVC: UITableViewController {
    
    // MARK: - IBoutlets

    @IBOutlet private var table: UITableView!
    @IBOutlet private var editButton: UIBarButtonItem!
    @IBOutlet private var addPostBtn: UIBarButtonItem!

    // MARK: - Properties

    var user: User?
    var posts: [Post] = []

    // MARK: - Life cycle

    override func viewWillAppear(_ animated: Bool) {
        fetchPosts()
    }

    // MARK: - IBActions

    @IBAction func didEdit(_ sender: UIBarButtonItem) {
        if table.isEditing {
            table.isEditing = false
            editButton.title = "Edit"
        } else {
            table.isEditing = true
            editButton.title = "Save"
            addPostBtn.isEnabled = false
        }
    }

    @IBAction func addPost(_ sender: Any) {
        let storyboard = UIStoryboard(name: "PostsView", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "NewPostVC") as! NewPostVC
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - Functions

    private func fetchPosts() {
        guard let userId = user?.id else {
            return
        }
        let pathUrl = "\(ApiConstants.postsPath)?userId=\(userId)"

        guard let url = URL(string: pathUrl) else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                return
            }
            do {
                self.posts = try JSONDecoder().decode([Post].self, from: data)
                print(self.posts)
            } catch {
                print(error)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        .resume()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "postsCell", for: indexPath)
        cell.textLabel?.text = "TITLE:" + " " + "\(post.title ?? "Not found")"
        cell.detailTextLabel?.text = "MESSAGE:" + " " + "\(post.body ?? "Not found")"
        cell.textLabel?.numberOfLines = 0
        return cell
    }

    // MARK: Table view delegates

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToComments", sender: indexPath)
    }

    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        true
    }

    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        posts.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete, let id = posts[indexPath.row].id {
            NetworkService.deletePost(postID: id) { [weak self] json, error in
                if json != nil {
                    self?.posts.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                } else if let error = error {
                    print(error)
                }
            }
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? CommentsTVC else {
            return
        }
        if let indexPath = sender as? IndexPath {
            let post = posts[indexPath.row].userId
            destination.postID = post
        }
    }
}
