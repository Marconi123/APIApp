//
//  CommentsVC.swift
//  APIApp
//
//  Created by Владислав on 5.09.22.
//

import Alamofire
import SwiftyJSON
import UIKit

final class NewPostVC: UIViewController {
    // MARK: - IBoutlets
    
    @IBOutlet var titleTF: UITextField!
    @IBOutlet var bodyTF: UITextView!
    
    // MARK: - Properties
    
    var user: User?
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        bodyTF.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    }
    
    // MARK: - IBAction
    
    @IBAction func titleTFAction(_ sender: UITextField) {}

    @IBAction func messageTFAction(_ sender: UITextField) {}

    @IBAction func saveBtnAct(_ sender: UIButton) {
        if let userID = user?.id,
           let title = titleTF.text,
           let body = bodyTF.text,
           let url = ApiConstants.postsPathURL
        {
            let parameters: Parameters = ["userId": userID,
                                          "title": title,
                                          "body": body]
            AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
                switch response.result {
                case .success:
                    self.navigationController?.popViewController(animated: true)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
