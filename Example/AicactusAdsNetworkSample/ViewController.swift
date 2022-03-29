//
//  ViewController.swift
//  AicactusAdsNetworkSample
//
//  Created by Sĩ Huỳnh on 01/03/2022.
//

import UIKit
import AicactusAdsNetwork

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        AicactusAdsNetwork.shared.setup("") { result in
            switch result {
            case .success(let container):
                print("Container ID \(container.id)")
            case .failure(let error):
                print("Failed to init: \(error)")
            }
        }
        
        
    }


}

