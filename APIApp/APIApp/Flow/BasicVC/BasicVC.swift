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
    
    var defaultIndicator = NVActivityIndicatorType.ballBeat
    
    func startAnimation(message: String?, type: NVActivityIndicatorType){
        startAnimating(message: message, type: type)
    }
    
    func stopAnimation() {
        stopAnimating()
    }
}
