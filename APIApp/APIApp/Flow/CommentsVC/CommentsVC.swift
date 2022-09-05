//
//  CommentsVC.swift
//  APIApp
//
//  Created by Владислав on 5.09.22.
//

import UIKit

final class CommentsVC: UIViewController {
    
    // MARK: - IBoutlets
    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var bodyTF: UITextField!
    
    // MARK: - Properties
    
    var user:User?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - IBAction

    @IBAction func titleTFAction(_ sender: UITextField) {
    }
    @IBAction func messageTFAction(_ sender: UITextField) {
    }
    @IBAction func saveBtnAct(_ sender: UIButton) {
        createPost()
    }
    func createPost() {
        let Url = String(format: "http://localhost:3000/posts")
        guard let serviceUrl = URL(string: Url) else { return }
        let parameters = Post(userId: user?.id, title: titleTF.text, body: bodyTF.text)
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONEncoder().encode(parameters.self) else { return }
        request.httpBody = httpBody
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
}
