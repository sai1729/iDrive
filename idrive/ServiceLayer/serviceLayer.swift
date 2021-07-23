//
//  serviceLayer.swift
//  idrive
//
//  Created by Dondeti, Sai Krishna on 23/07/21.
//

import Foundation
import UIKit
class serviceLayer {
    func loadDataValues() {
        guard let loansUrl = URL(string: "http://api.kivaws.org/v1/loans/newest.json") else {
            return
        }
     
        let request = URLRequest(url: loansUrl)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
     
            if let error = error {
                print(error)
                return
            }
     
            if let data = data {
                ViewController.loans = self.parseJsonData(data: data)
                if let delegate = UIApplication.shared.keyWindow?.rootViewController as? ViewController {
                    DispatchQueue.main.async {
                        delegate.loansView.reloadData()
                    }
                }
             }
        })
     
        task.resume()
    }


    func parseJsonData(data: Data) -> [loansData] {
        
        
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
            
            let jsonLoans = jsonResult?["loans"] as! [AnyObject]
            for jsonloan in jsonLoans {
                var loanValues = loansData()
                loanValues.name = jsonloan["name"] as! String
                loanValues.activity = jsonloan["activity"] as! String
                loanValues.sector = jsonloan["sector"] as! String
                var location = jsonloan["location"] as! [String:AnyObject]
                loanValues.country = location["country"] as! String
                location = location["geo"] as! [String:AnyObject]
                loanValues.geo = location["pairs"] as! String
                ViewController.loans.append(loanValues)
            }
            
        } catch {
            print(error)
        }
        return ViewController.loans
    }
}
