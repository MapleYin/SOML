//
//  MapViewController.swift
//  SOML
//
//  Created by Maple Yin on 2019/1/28.
//  Copyright © 2019 Maple.im. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
//    let locationManager = CLLocationManager()

    let mapView = MKMapView()
    let searchController = UISearchController()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.mapView.showsUserLocation = true
        self.mapView.showsScale = true
        self.view.addSubview(self.mapView)
        self.mapView.snp.makeConstraints { (maker) in
            maker.edges.equalTo(self.view)
        }
        
        
        self.mapView.delegate = self
        
    }
    
    
    func updateLoactionInfo() {
        let location = self.mapView.userLocation
        self.mapView.setRegion(MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 500, longitudinalMeters: 500), animated: false)
        
    }

}



extension MapViewController: MKMapViewDelegate {
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        self.updateLoactionInfo()
    }
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        
    }
    
    func mapViewDidStopLocatingUser(_ mapView: MKMapView) {
        
    }
    
   
}
