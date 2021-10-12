//
//  ViewController.swift
//  locationFinder
//
//  Created by Engin KUK on 12.10.2021.
//

import UIKit
import SwiftCoroutine

class ViewController: UIViewController {

    @IBOutlet weak var locationLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let _ = LocationProvider.shared
    }

    @IBAction func getLocationPressed(_ sender: Any) {
 
        let future1: CoFuture<(lat: CGFloat,long: CGFloat)?> = LocationProvider.shared.getMyLocation()
        // execute coroutine on the main thread
        DispatchQueue.main.startCoroutine {
            if let location = try future1.await(timeout: DispatchTimeInterval.seconds(10)) {
               self.locationLabel.text = "lat: " + location.lat.description + "\nlong: " + location.long.description
                print(location)
            } else {
               print("error")
            }
        }
    }
  
}

