//
//  ViewController.swift
//  idrive
//
//  Created by Dondeti, Sai Krishna on 23/07/21.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, loansDataProtocol {
    
    var loans = [loansData]()
    
    func loansDataSending(loanData: [loansData]) {
        // protocol to update loan values
        self.loans = loanData
        self.loansView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // returning loans count
        return self.loans.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = loansView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath) as! LoansTableViewCell
        // Assigning Values to row in tableView
        cell.userName.text = self.loans[indexPath.row].name
        cell.activityValue.text = self.loans[indexPath.row].activity
        cell.userSector.text = self.loans[indexPath.row].sector
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //selected user values to display in mapViewController
        let selectedUser = self.loans[indexPath.row]
        let geoValues  = selectedUser.geo.components(separatedBy: " ")
        let mapViewControllerName = self.storyboard?.instantiateViewController(withIdentifier: "MapView") as! MapViewController
        mapViewControllerName.latitude = Double(geoValues[0])!
        mapViewControllerName.longitude = Double(geoValues[1])!
        mapViewControllerName.countryname = selectedUser.country
        mapViewControllerName.usernameValue = selectedUser.name
        let navController = UINavigationController(rootViewController: mapViewControllerName)
        self.present(navController, animated:true, completion: nil)
    }
    

    
    @IBOutlet weak var loansView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //Calling service layer to load loan Values from API
        serviceLayer().loadDataValues()
        //registering xib to use in tableView
        loansView.register(UINib(nibName: "LoansTableViewCell", bundle: nil), forCellReuseIdentifier:"cellIdentifier")
        self.loansView.reloadData()
    }
}
