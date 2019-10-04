//
//  ViewController.swift
//  Kosmos
//
//  Created by Emir SARI on 4.10.2019.
//  Copyright © 2019 Emir SARI. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import SDWebImage

class ViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var explanationView: UITextView!
    
    let apiURL = "https://api.nasa.gov/planetary/apod?api_key=CKr7kE6kcJMKqIPMhSKkvNWMQ8pvbXkdKdSpEomW"
  
    override func viewDidLoad() {
        super.viewDidLoad()
        getPhotoData()
    }
    
    @IBAction func shareTapped(_ sender: UIButton) {
        guard let image = imageView.image?.jpegData(compressionQuality: 1) else {
            print("No image found")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    func getPhotoData() {
        Alamofire.request(apiURL).responseJSON { response in
            if response.result.isSuccess {
                let photoJSON: JSON = JSON(response.result.value!)
                self.displayPhotoData(json: photoJSON)
            } else {
                print("Error: \(String(describing: response.result.error))")
            }
        }
    }
    
    func displayPhotoData(json: JSON) {
        let photoData = json["hdurl"].stringValue
        imageView.sd_setImage(with: URL(string: photoData), placeholderImage: UIImage(named: ""))
        let explanationData = json["explanation"].stringValue
        explanationView.text = explanationData
    }
}
