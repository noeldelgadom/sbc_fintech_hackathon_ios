//
//  MovementsController.swift
//  HackatonFintech
//
//  Created by Victor Manuel Castillo Torres on 1/27/18.
//  Copyright © 2018 HackatonFintech. All rights reserved.
//

import Foundation
import UIKit

class MovementsController:UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var movementsCount = 0;
    var movements: [[String:Any]] = [];
    
    @IBOutlet weak var tableMovements: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movementsCount;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovementsTableCell
        cell.concept.text = (movements[indexPath.row]["tr_description"] as! String)
        cell.date.text = (movements[indexPath.row]["tr_date"] as! String)
        var price = movements[indexPath.row]["tr_amount"] as! Int
        if( price < 0){
            price = price * -1
            cell.movementType.text = "Pago"
        }else{
            cell.movementType.text = "Depósito"
        }
        cell.price.text = String(price)
        return cell
    
    }
    

    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadMovements()
    }
    
    func loadMovements(){
        let defaults = UserDefaults.standard
        let type = defaults.string(forKey: "type")!
        let id = defaults.string(forKey: "id")!
        if(type == "User"){
            _API.getUsersStatement(Int(id)!).request(.get).onSuccess({ (entity)
                in
                let json_content = entity.content as! [String:Any]
                let transactions = json_content["transactions"] as! [[String:Any]]
                self.movementsCount = transactions.count
                self.movements = transactions
                DispatchQueue.main.async{
                        self.tableMovements.reloadData()
                }
                

            })
        }else if(type == "Company"){
            _API.getCompaniesStatement(Int(id)!).request(.get).onSuccess({ (entity)
                in
                let json_content = entity.content as! [String:Any]
                let transactions = json_content["transactions"] as! [[String:Any]]
                self.movementsCount = transactions.count
                self.movements = transactions
                DispatchQueue.main.async{
                    self.tableMovements.reloadData()
                }
            })
        }
    }
}
