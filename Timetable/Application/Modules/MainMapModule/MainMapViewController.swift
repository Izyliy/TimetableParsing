//
//  MainMapViewController.swift
//  Timetable
//
//  Created by Павел Грабчак on 07.08.2025.
//

import UIKit
import MapKit
import CoreLocation

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
    
    let trackButton: MKUserTrackingButton = {
        let view = MKUserTrackingButton()
        
        view.tintColor = UIColor(named: "BrandGreen")
        view.backgroundColor = .white
        view.layer.shadowRadius = 1.5
        view.layer.shadowOpacity = 1
        view.layer.shadowColor = UIColor.gray.cgColor
        view.isHidden = true
        
        return view
    }()
    
    let locationManager = CLLocationManager()
    
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
        trackButton.mapView = mapView
        locationManager.delegate = self
        
        title = "Карта"
        
        let layersButton = UIBarButtonItem(image: UIImage(named: "Layers"),
                                           style: .plain,
                                           target: self,
                                           action: #selector(layersPressed(_:)))
        navigationItem.rightBarButtonItem = layersButton
        
        setTrackButtonVisibility()
    }
    
    private func setVisuals() {
        view.addSubview(mapView)
        view.addSubview(trackButton)
        
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        
        trackButton.snp.makeConstraints { make in
            make.right.equalTo(mapView.snp.right).inset(16)
            make.bottom.equalTo(mapView.snp.bottom).inset(16)
        }
    }
    
    private func setTrackButtonVisibility() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            trackButton.isHidden = true
        case .authorizedAlways, .authorizedWhenInUse:
            trackButton.isHidden = false
        @unknown default:
            locationManager.requestWhenInUseAuthorization()
        }

    }
    
    @objc
    private func layersPressed(_ sender: UIBarButtonItem) {
        mapView.mapType = mapView.mapType == .hybrid ? .standard : .hybrid
    }
}

extension MainMapViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        setTrackButtonVisibility()
    }
}
