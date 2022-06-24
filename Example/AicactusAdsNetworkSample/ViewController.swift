//
//  ViewController.swift
//  AicactusAdsNetworkSample
//
//  Created by Sĩ Huỳnh on 01/03/2022.
//

import UIKit
import AiactivAdNetwork

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        AiactivAdNetwork.shared.setup("b8a3ccf2-5d49-4912-b2cc-87dc46e10277") { result in
            switch result {
            case .success(let container):
                print("Container ID \(container.id)")
            case .failure(let error):
                print("Failed to init: \(error)")
            }
        }
    }

}

extension ViewController: AdViewDelegate {
    func adView(_ adView: AdView, didFailLoad error: AdsNetworkSDKError) {
        
    }
    
    func adView(_ adView: AdView) {
        
    }
    
    func adView(_ adView: AdView, didClickAd url: URL) {
        
    }
}

