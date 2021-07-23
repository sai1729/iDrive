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
        loansMap()
    }
    
    func loansMap() {
        let annotations = MKPointAnnotation()
        annotations.title = self.countryname
        annotations.coordinate = CLLocationCoordinate2D(latitude:self.latitude ?? 0.0, longitude: self.longitude ?? 0.0)
        mapView.addAnnotation(annotations)
    }

}