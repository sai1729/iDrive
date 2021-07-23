//
//  ViewController.swift
//  idrive
//
//  Created by Dondeti, Sai Krishna on 23/07/21.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    static var loans = [loansData]()
    static let servicelayer = serviceLayer()
    static let mapView = MapViewController()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewController.loans.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = loansView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath) as! LoansTableViewCell

        cell.userName.text = ViewController.loans[indexPath.row].name
        cell.activityValue.text = ViewController.loans[indexPath.row].activity
        cell.userSector.text = "Sector --> " + ViewController.loans[indexPath.row].sector
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = ViewController.loans[indexPath.row]
        let countryname = selectedItem.country
        let geoValues  = selectedItem.geo.components(separatedBy: " ")
        let name = selectedItem.name
        let mapViewControllerName = self.storyboard?.instantiateViewController(withIdentifier: "MapView") as! MapViewController
        mapViewControllerName.latitude = Double(geoValues[0])!
        mapViewControllerName.longitude = Double(geoValues[1])!
        mapViewControllerName.countryname = countryname
        mapViewControllerName.usernameValue = name
        let navController = UINavigationController(rootViewController: mapViewControllerName)
        self.present(navController, animated:true, completion: nil)
    }
    

    
    @IBOutlet weak var loansView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewController.servicelayer.loadDataValues()
        loansView.register(UINib(nibName: "LoansTableViewCell", bundle: nil), forCellReuseIdentifier:"cellIdentifier")
        self.loansView.reloadData()
    }
}


