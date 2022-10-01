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
    let locationManager: CLLocationManager = CLLocationManager()
    private let places: [Place] = [
        Place(name: "Первый почтарь", coordinate: CLLocationCoordinate2D(latitude: 51.50988, longitude: -0.1337), image: "1"),
    Place(name: "Старый знакомый", coordinate: CLLocationCoordinate2D(latitude: 51.51007, longitude: -0.1335), image: "2"),
    Place(name: "Знаменитый петух", coordinate: CLLocationCoordinate2D(latitude: 51.50975, longitude: -0.1339), image: "3"),
    Place(name: "Пять рук", coordinate: CLLocationCoordinate2D(latitude: 51.50990, longitude: -0.1340), image: "4"),
    Place(name: "Славная компания", coordinate: CLLocationCoordinate2D(latitude: 51.50985, longitude: -0.1334), image: "5")
    ]
    
    func addPlace() {
        for i in places {
            let a = MKPointAnnotation()
            a.title = i.name
            a.coordinate = i.coordinate
            
            let b = MKAnnotationView()
            b.image = i.image
            b.annotation = a
            self.mapView.addAnnotation(b.annotation!)
        }
    }
    
    func myLocation() {
        mapView.setRegion(MKCoordinateRegion(center: mapView.userLocation.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius), animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        addPlace()
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
    }
    
    @IBAction func myLocation(_ sender: Any) {
        myLocation()
        print(mapView.userLocation.coordinate)
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
        if annotation is MKUserLocation { return nil }
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationView") ?? MKAnnotationView()
        annotationView.image = UIImage(named: "1")
        return annotationView
    }
}

class Place: NSObject, MKAnnotation {
    var name: String
    var coordinate: CLLocationCoordinate2D
    var image: UIImage
    init(name: String, coordinate: CLLocationCoordinate2D, image: String) {
        self.name = name
        self.coordinate = coordinate
        self.image = UIImage(named: image)!
    }
}
