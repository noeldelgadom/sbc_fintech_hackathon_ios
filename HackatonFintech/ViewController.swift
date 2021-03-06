//
//  ViewController.swift
//  HackatonFintech
//
//  Created by Victor Manuel Castillo Torres on 1/26/18.
//  Copyright © 2018 HackatonFintech. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        sleep(3)
        let defaults = UserDefaults.standard
        if let id = defaults.string(forKey: "id"){
            self.performSegue(withIdentifier: "mainScreenSegue", sender: nil)
        }else{
            self.performSegue(withIdentifier: "signInSegue", sender: nil)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

