//
//  PostsTVC.swift
//  APIApp
//
//  Created by Владислав on 4.09.22.
//

import UIKit

final class PostsTVC: UITableViewController {
    
    // MARK: - IBoutlets
    
    @IBOutlet private var table: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var addPostBtn: UIBarButtonItem!
    
    // MARK: - Properties
    
    var user: User?
    var posts: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPosts()
    }
    
    // MARK: - IBactions
    
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
        let vc = storyboard.instantiateViewController(withIdentifier: "CommentsVC") as! CommentsVC
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    

    // MARK: - Functions

    private func fetchPosts() {
        guard let userId = user?.id else { return }
        let pathUrl = "\(ApiConstants.postsPath)?userId=\(userId)"

        guard let url = URL(string: pathUrl) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
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
        cell.textLabel?.text = post.title
        cell.detailTextLabel?.text = post.body
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool { return true }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        posts.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            posts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
}

