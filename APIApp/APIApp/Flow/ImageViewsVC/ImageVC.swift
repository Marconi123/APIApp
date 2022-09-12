//
//  ImageVC.swift
//  APIApp
//
//  Created by Владислав on 31.08.22.
//

import UIKit

final class ImageVC: BasicVC {
    // MARK: - IBOutlets

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var stackView: UIStackView!
    
    // MARK: - Properties

    private let imageUrl = "https://img1.akspic.ru/crops/3/9/4/7/6/167493/167493-atmosfera-zemlya-svet-mir-priroda-3840x2160.jpg"

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImageData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateUI(with: size)
    }
    
    // MARK: - Functions

    private func fetchImageData() {
        guard let url = URL(string: imageUrl) else { return }
        self.startAnimation(message: nil, type: .lineScale)
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    self?.imageView.image = UIImage(data: data)
                }
                if let response = response {
                    print(response)
                }
                if let error = error {
                    print(error)
                }
                self!.stopAnimation()
            }
        }.resume()
    }
    
    private func updateUI(with size: CGSize) {
        let isVertical = size.width < size.height
        stackView.axis = isVertical ? .vertical : .horizontal
    }
}
