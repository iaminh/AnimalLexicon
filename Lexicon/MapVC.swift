//
//  MapVC.swift
//  Lexicon
//
//  Created by Minh on 11/8/16.
//  Copyright © 2016 Lexicon. All rights reserved.
//

import UIKit
import MapKit


let annotations = [
    MapPin(0 , lat: 50.1197322, lon: 14.4039967, name: "Sovy"),
    MapPin(1 , lat: 50.1193158, lon: 14.4035331, name: "Sobi"),
    MapPin(2 , lat: 50.1189992, lon: 14.4031356, name: "Zubři"),
    MapPin(3 , lat: 50.1184317, lon: 14.4029008, name: "Bizoni"),
    MapPin(4 , lat: 50.1180236, lon: 14.4018083, name: "Horští kopytníci"),
    MapPin(5 , lat: 50.1190417, lon: 14.4043481, name: "Vlci"),
    MapPin(6 , lat: 50.1189253, lon: 14.4037150, name: "Takini"),
    MapPin(7 , lat: 50.1186831, lon: 14.4038867, name: "Pekariové"),
    MapPin(8 , lat: 50.1182517, lon: 14.4034328, name: "Velbloudi"),
    MapPin(9 , lat: 50.1187567, lon: 14.4049922, name: "Hyeny"),
    MapPin(10, lat: 50.1184811, lon: 14.4052789, name: "Anoa"),
    MapPin(11, lat: 50.1180972, lon: 14.4046581, name: "Lamy"),
    MapPin(12, lat: 50.1177850, lon: 14.4043594, name: "Přímorožci"),
    MapPin(13, lat: 50.1174783, lon: 14.4036000, name: "Plazi"),
    MapPin(14, lat: 50.1172497, lon: 14.4018225, name: "Ptačí mokřady"),
    MapPin(15, lat: 50.1172406, lon: 14.4013722, name: "Ibisové"),
    MapPin(16, lat: 50.1169225, lon: 14.4023567, name: "Jeřábi"),
    MapPin(17, lat: 50.1168669, lon: 14.4027417, name: "Kachny"),
    MapPin(18, lat: 50.1164967, lon: 14.4034058, name: "Tygři"),
    MapPin(19, lat: 50.1164331, lon: 14.4045497, name: "Velemlokárium"),
    MapPin(20, lat: 50.1153992, lon: 14.4049239, name: "Pavilon goril"),
    MapPin(21, lat: 50.1155092, lon: 14.4043825, name: "Tamaríni"),
    MapPin(22, lat: 50.1178006, lon: 14.4061872, name: "Klokani"),
    MapPin(23, lat: 50.1165742, lon: 14.4068603, name: "Pelikáni"),
    MapPin(24, lat: 50.1158861, lon: 14.4076811, name: "Vodní svět"),
    MapPin(25, lat: 50.1153731, lon: 14.4091208, name: "Dravci"),
    MapPin(26, lat: 50.1156336, lon: 14.4095564, name: "Supi"),
    MapPin(27, lat: 50.1161006, lon: 14.4092461, name: "Dvojzoborožci"),
    MapPin(28, lat: 50.1164275, lon: 14.4079608, name: "Terárium"),
    MapPin(29, lat: 50.1165475, lon: 14.4073836, name: "Mravenečníci"),
    MapPin(30, lat: 50.1170478, lon: 14.4083983, name: "Rákosův pavilon"),
    MapPin(31, lat: 50.1175775, lon: 14.4087597, name: "Klokani"),
    MapPin(32, lat: 50.1173675, lon: 14.4083425, name: "Lohové"),
    MapPin(33, lat: 50.1175861, lon: 14.4080575, name: "Emuové"),
    MapPin(34, lat: 50.1175128, lon: 14.4074653, name: "Kasuáři"),
    MapPin(35, lat: 50.1178061, lon: 14.4066094, name: "Adaxi"),
    MapPin(36, lat: 50.1177492, lon: 14.4053511, name: "Koně Převalského"),
    MapPin(37, lat: 50.1178839, lon: 14.4058447, name: "Vlci hřivnatí"),
    MapPin(38, lat: 50.1178267, lon: 14.4076922, name: "Zebry"),
    MapPin(39, lat: 50.1178744, lon: 14.4085214, name: "Jihoamerické šelmy"),
    MapPin(40, lat: 50.1180650, lon: 14.4090556, name: "Vydry"),
    MapPin(41, lat: 50.1182314, lon: 14.4085881, name: "Sitatungy"),
    MapPin(42, lat: 50.1185811, lon: 14.4082419, name: "Pavilon hrochů"),
    MapPin(43, lat: 50.1191692, lon: 14.4057958, name: "Údolí slonů"),
    MapPin(44, lat: 50.1178839, lon: 14.4058447, name: "Vlci hřivnatí"),
    MapPin(45, lat: 50.1165086, lon: 14.4052247, name: "Pavilon velkých želv"),
    MapPin(46, lat: 50.1172889, lon: 14.4032336, name: "Orlosupí"),
    MapPin(47, lat: 50.1175358, lon: 14.4094000, name: "Medvědi lední"),
    MapPin(48, lat: 50.1175669, lon: 14.4101933, name: "Indonéská džungle"),
    MapPin(49, lat: 50.1161472, lon: 14.4070306, name: "Plameňáci")
]
class MapVC: BaseVC {
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.delegate = self
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .none
            mapView.mapType = .standard
            var region: MKCoordinateRegion = MKCoordinateRegion()
            region.center = CLLocationCoordinate2DMake(50.116346, 14.406358)
            region.span = MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003)
            mapView.setRegion(region, animated: true)
        }
    }

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.rowHeight = 45
            tableView.registerCell(MapCell.self)
        }
    }
    
    fileprivate var locationManager: CLLocationManager!
    fileprivate var currentLocation: CLLocation?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Mapa Zoo"
        
        
        mapView.addAnnotations(annotations)
        initLocationManager()
    }

    @IBAction func navigateButtonTapped(_ sender: AnyObject) {
        let placemark = MKPlacemark(coordinate: annotations[0].coordinate, addressDictionary:nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "ZOO PRAHA"
        mapItem.openInMaps(
            launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        )
    }

}

extension MapVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        // Better to make this class property
        let annotationIdentifier = "AnnotationIdentifier"
        
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
        }
        
        if let annotationView = annotationView, let pin = annotation as? MapPin {
            // Configure your annotation view here
            annotationView.canShowCallout = true
            annotationView.image = #imageLiteral(resourceName: "zoo-pin")
                                    .withRenderingMode(.alwaysTemplate)
                .colorized(color: UIColor.computeColorFromInt(int: pin.id, alpha: 1.0, brightNess: 255))
            
        }
        
        return annotationView
    }
}

extension MapVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return annotations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cell: MapCell.self, indexPath: indexPath)!
        cell.titleLabel.text = annotations[indexPath.row].name
        cell.iconView.image =  #imageLiteral(resourceName: "zoo-pin")
                                .withRenderingMode(.alwaysTemplate)
            .colorized(color: UIColor.computeColorFromInt(int: annotations[indexPath.row].id, alpha: 1.0, brightNess: 255))
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mapView.selectAnnotation(annotations[indexPath.row], animated: true)
    }
}

extension MapVC {
    fileprivate func initLocationManager() {
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        let status = CLLocationManager.authorizationStatus()
        if status == .notDetermined || status == .denied || status == .authorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
        }
        
        if status == .denied {
            showAlertMessage("Permission denied", message: "Permission denied, please enable location when in use in your settings")
        }
        
        startTrackingLocation()
    }
    
    fileprivate func startTrackingLocation() {
        locationManager.startUpdatingLocation()
    }
}
