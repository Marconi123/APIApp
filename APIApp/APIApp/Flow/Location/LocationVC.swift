//
//  LocationVC.swift
//  APIApp
//
//  Created by Владислав on 12.09.22.
//

import UIKit
import MapKit

final class LocationVC: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var mapView: MKMapView!
    
    // MARK: - Properties
    
    var user:User?

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        title = "Location"
    }
    
    // MARK: - Functions
    
    private func setupUI() {
        if
            let user = user,
            let username = user.username,
            let geo = user.address?.geo,
            let lngStr = geo.lng,
            let latStr = geo.lat,
            let lng = Double(lngStr),
            let lat = Double(latStr)
        {
            let annotaion = MKPointAnnotation()
            annotaion.coordinate.latitude = lat
            annotaion.coordinate.longitude = lng
            annotaion.title = "\(username)'s location"
            annotaion.subtitle = "Detail user location"
            mapView.addAnnotation(annotaion)
        }
    }
}
