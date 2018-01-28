//
//  ScanQRControlller.swift
//  HackatonFintech
//
//  Created by Victor Manuel Castillo Torres on 1/27/18.
//  Copyright © 2018 HackatonFintech. All rights reserved.
//

import Foundation
import UIKit

class ScanQRController:UIViewController{
    var url: String?
    var fullUrl: String?
    @IBOutlet weak var imageViewForQR: UIImageView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.fullUrl = "https://dinub-api.herokuapp.com\(self.url!)"
        self.downloadAndSetImage()
    }
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func downloadAndSetImage(){
        let urlObject = URL.init(string: self.fullUrl!)!
        URLSession.shared.dataTask(with: urlObject) { (data, response, error) in
            if error != nil {
                print("Failed fetching image:", error)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Not a proper HTTPURLResponse or statusCode")
                return
            }
            
            DispatchQueue.main.async {
                self.imageViewForQR.image = UIImage(data: data!)
            }
        }.resume()
    }
}
