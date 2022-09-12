//
//  BasicVC.swift
//  APIApp
//
//  Created by Владислав on 3.09.22.
//

import UIKit
import NVActivityIndicatorView
import NVActivityIndicatorViewExtended

class BasicVC: UIViewController, NVActivityIndicatorViewable {
    
    // MARK - Properties
    /// Indicatior
    var defaultIndicator = NVActivityIndicatorType.ballBeat
    
    // MARK: - Functions
    
    func startAnimation(message: String?, type: NVActivityIndicatorType){
        startAnimating(message: message, type: type)
    }
    
    func stopAnimation() {
        stopAnimating()
    }
}
