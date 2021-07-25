//
//  serviceLayer.swift
//  idrive
//
//  Created by Dondeti, Sai Krishna on 23/07/21.
//

import Foundation
import UIKit
class serviceLayer:UIViewController {
    var loans = [loansData]()
    var delegate: loansDataProtocol? = nil
    func loadDataValues() {
        //loan API for users
        guard let loansUrl = URL(string: "http://api.kivaws.org/v1/loans/newest.json") else {
            return
        }
        //creating request for loans url
        let request = URLRequest(url: loansUrl)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                print(error)
                return
            }
            //data from task
            if let data = data {
                self.loans = self.parseJsonData(data: data)
                DispatchQueue.main.async {
                    if let delegate = UIApplication.shared.keyWindow?.rootViewController as? ViewController {
                            delegate.loansDataSending(loanData: self.loans)
                    }
                }
             }
        })
        task.resume()
    }

    //parsing json from available API Data
    func parseJsonData(data: Data) -> [loansData] {
        
        
        do {
            //creating jsonResult as NSDictionart
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
            
            //fetching loans data from jsonResult
            let jsonLoans = jsonResult?["loans"] as! [AnyObject]
            for jsonloan in jsonLoans {
                var loanValues = loansData()
                loanValues.name = jsonloan["name"] as! String
                loanValues.activity = jsonloan["activity"] as! String
                loanValues.sector = jsonloan["sector"] as! String
                //location values is inside another json so creating a new json
                var location = jsonloan["location"] as! [String:AnyObject]
                loanValues.country = location["country"] as! String
                location = location["geo"] as! [String:AnyObject]
                loanValues.geo = location["pairs"] as! String
                self.loans.append(loanValues)
            }
            
        } catch {
            print(error)
        }
        return self.loans
    }
}

protocol loansDataProtocol {
    // using loansDataProtocol to transfer data from one to another
    func loansDataSending(loanData: [loansData])
}
