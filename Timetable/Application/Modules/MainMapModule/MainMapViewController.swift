//
//  MainMapViewController.swift
//  Timetable
//
//  Created by Павел Грабчак on 07.08.2025.
//

import UIKit
import MapKit

class MainMapViewController: UIViewController {
    
    let mapView: MKMapView = {
        let view = MKMapView()
        
        view.mapType = .hybrid
        view.pointOfInterestFilter = .excludingAll
        view.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 45.045927, longitude: 38.922627),
                                         latitudinalMeters: 1100,
                                         longitudinalMeters: 1100)
        
        return view
    }()
    
    var displayManager: MainMapDisplayManager?
    var presenter: MainMapPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setVisuals()
        presenter?.setupInitialState()
    }
    
    private func configure() {
        displayManager = MainMapDisplayManager(view: self)
        presenter = MainMapPresenter(view: self)
        
        title = "Карта"
    }
    
    private func setVisuals() {
        view.addSubview(mapView)
        
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
    }
}
