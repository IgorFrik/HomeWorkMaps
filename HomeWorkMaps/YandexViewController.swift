//
//  YandexViewController.swift
//  HomeWorkMaps
//
//  Created by Igor Frik on 18.09.2022.
//

import UIKit
import YandexMapsMobile

class YandexViewController: UIViewController {

    @IBOutlet weak var yandexMap: YMKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        yandexMap.mapWindow.map.move(
//            with: YMKCameraPosition.init(target: YMKPoint(latitude: 55.751574, longitude: 37.573856), zoom: 15, azimuth: 0, tilt: 0),
//            animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 5),
//            cameraCallback: nil)
    }
}
