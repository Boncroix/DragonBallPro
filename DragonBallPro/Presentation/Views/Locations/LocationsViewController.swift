//
//  LocationsViewController.swift
//  DragonBallPro
//
//  Created by Jose Bueno Cruz on 31/3/24.
//

import UIKit
import Combine
import MapKit

class LocationsViewController: UIViewController {
    
    private var viewModel: LocationsViewModel
    private var suscriptors = Set<AnyCancellable>()
    private var locations: [Location] = []
    private let locationManager = CLLocationManager()
    
    //MARK: IBOutlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var segmentMapType: UISegmentedControl!
    
    //MARK: - Inits
    init(viewModel: LocationsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        debugPrint("Locations released")
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        binding()
        configUI()
        checkLocationAuthorizationSatus()
    }
}

//MARK: - Binding ViewModel
extension LocationsViewController {
    private func binding() {
        self.viewModel.$locations
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.updateDataInterface()
            }
            .store(in: &suscriptors)
    }
}

//MARK: - Config UI
extension LocationsViewController {
    private func configUI() {
        navigationItem.title = NSLocalizedString("Locations", comment: "Localizaciones")
        mapView.delegate = self
        mapView.showsUserTrackingButton = true
        mapType()
    }
    
    private func mapType() {
        segmentMapType.selectedSegmentIndex = 0
        segmentMapType.addTarget(self, action: #selector(chageMap(_:)), for: .valueChanged)
    }
}

//MARK: - MapView
extension LocationsViewController: MKMapViewDelegate {
    private func updateDataInterface() {
        addAnnotations()
        if let annotation = mapView.annotations.first {
            let region = MKCoordinateRegion(center: annotation.coordinate,
                                            latitudinalMeters: 100000,
                                            longitudinalMeters: 100000)
            mapView.region = region
        }
    }
    
    private func addAnnotations() {
        var annotations = [HeroAnotation]()
        let (name, id) = viewModel.heroNameAndId()
        for location in viewModel.locations {
            annotations.append(
                HeroAnotation.init(coordinate: .init(latitude: Double(location.latitude ?? "") ?? 0.0,
                                                     longitude: Double(location.longitude ?? "") ?? 0.0),
                                   title: name,
                                   id: id,
                                   date: location.date)
            
            )
        }
        mapView.addAnnotations(annotations)
    }
    
    private func checkLocationAuthorizationSatus() {
        let status = locationManager.authorizationStatus
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            mapView.showsUserLocation = false
        case .authorizedAlways, .authorizedWhenInUse:
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        guard let heroAnnotation = annotation as? HeroAnotation else {
            return
        }
        debugPrint("Annotation selected of hero \(heroAnnotation.title ?? "")")
        debugPrint("Located on \(heroAnnotation.date ?? "")")
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is HeroAnotation else {
            return nil
        }
        if let annotation = mapView.dequeueReusableAnnotationView(withIdentifier: HeroAnnotationView.reuseIdentifier) {
            return annotation
        }
        return HeroAnnotationView.init(annotation: annotation, reuseIdentifier: HeroAnnotationView.reuseIdentifier)
    }
}

//MARK: - Objc
extension LocationsViewController {
    
    @objc func chageMap(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        case 2:
            mapView.mapType = .hybrid
        default:
            break
        }
    }
}
