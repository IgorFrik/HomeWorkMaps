//
//  ViewController.swift
//  HomeWorkMaps
//
//  Created by Igor Frik on 18.09.2022.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var regionRadius: CLLocationDistance = 400
    var point = CLLocationCoordinate2D()
    let locationManager: CLLocationManager = CLLocationManager()
    private let places: [Place] = [
        Place(title: "Первый почтарь", coordinate: CLLocationCoordinate2D(latitude: 51.50988, longitude: -0.1337), image: "1"),
    Place(title: "Старый знакомый", coordinate: CLLocationCoordinate2D(latitude: 51.51007, longitude: -0.1335), image: "2"),
    Place(title: "Знаменитый петух", coordinate: CLLocationCoordinate2D(latitude: 51.50975, longitude: -0.1339), image: "3"),
    Place(title: "Пять рук", coordinate: CLLocationCoordinate2D(latitude: 51.50990, longitude: -0.1340), image: "4"),
    Place(title: "Славная компания", coordinate: CLLocationCoordinate2D(latitude: 51.50985, longitude: -0.1334), image: "5")
    ]

    func myLocation() {
        mapView.setRegion(MKCoordinateRegion(center: point, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius), animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.addAnnotations(places)
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
    }
    
    @IBAction func myLocation(_ sender: Any) {
        point = mapView.userLocation.coordinate
        myLocation()
    }
    
    @IBAction func zoomIn(_ sender: Any) {
        if regionRadius >= 100 { regionRadius -= 100 }
        myLocation()
    }
    
    @IBAction func zoomOut(_ sender: Any) {
        regionRadius += 100
        myLocation()
    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Place else { return nil }
        let identifier = "place"
        var view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(
          withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView( annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        view.markerTintColor = .clear
        view.image = annotation.image
        return view
      }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let place = view.annotation as? Place else { return }
        point = place.coordinate
        myLocation()
    }
}

class Place: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    var image: UIImage
    init(title: String, coordinate: CLLocationCoordinate2D, image: String) {
        self.title = title
        self.coordinate = coordinate
        self.image = UIImage(named: image)!
        
        super.init()
    }
}
