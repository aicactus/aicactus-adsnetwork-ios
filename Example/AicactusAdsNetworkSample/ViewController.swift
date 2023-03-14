//
//  ViewController.swift
//  AicactusAdsNetworkSample
//
//  Created by Sĩ Huỳnh on 01/03/2022.
//

import UIKit
import AiactivUniversalSDK

class ViewController: UIViewController {

    @IBOutlet weak var nativeAdView: NativeAdTemplateView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        nativeAdView.contentView.delegate = self
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.nativeAdView.contentView.loadAd(adUnitID: 534, adRequest: AdRequest())
        }
        
        
    }

}

extension ViewController: NativeAdViewDelegate {
    func onNativeAdViewEvent(_ view: AiactivUniversalSDK.NativeAdView, adEvent event: AiactivUniversalSDK.NativeAdView.NativeAdEvent) {
        print("Event: \(event.data.name) - error \(event.data.message ?? "nil")")
    }
}


