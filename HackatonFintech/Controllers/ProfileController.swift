//
//  ProfileController.swift
//  HackatonFintech
//
//  Created by Victor Manuel Castillo Torres on 1/27/18.
//  Copyright © 2018 HackatonFintech. All rights reserved.
//

import Foundation
import UIKit

class ProfileController:UIViewController{
    
    @IBOutlet weak var email: UILabel!
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        self.email.text = defaults.string(forKey: "email")!
    }
}
