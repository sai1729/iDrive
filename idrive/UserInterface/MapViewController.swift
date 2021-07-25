//
//  MapViewController.swift
//  idrive
//
//  Created by Dondeti, Sai Krishna on 23/07/21.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    var countryname: String?
    var usernameValue: String?
    var latitude: Double?
    var longitude: Double?
    @IBOutlet var nameTitle: UILabel!
    @IBOutlet var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameTitle.text = usernameValue
        self.title = "Map View"
        loansMap()
    }
    
    func loansMap() {
        //setting location and region to user location
        let annotations = MKPointAnnotation()
        annotations.title = self.countryname
        annotations.coordinate = CLLocationCoordinate2D(latitude:self.latitude ?? 0.0, longitude: self.longitude ?? 0.0)
        mapView.addAnnotation(annotations)
        let latitude:CLLocationDegrees = self.latitude ?? 0.0
        let longitude:CLLocationDegrees = self.longitude ?? 0.0
        let latDelta:CLLocationDegrees = 0.05
        let lonDelta:CLLocationDegrees = 0.05
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        let location = CLLocationCoordinate2DMake(latitude, longitude)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: false)
    }

}
