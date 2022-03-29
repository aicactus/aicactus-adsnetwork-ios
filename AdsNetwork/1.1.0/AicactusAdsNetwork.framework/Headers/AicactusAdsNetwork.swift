//
//  AicactusAdsNetwork.swift
//  AdsNetworkSDK
//
//  Created by Sĩ Huỳnh on 31/10/2021.
//

import Foundation

public class AicactusAdsNetwork {
        
    public static let shared = AicactusAdsNetwork()
    
    private let lock = NSLock()
        
    private var sdkConfiguration: SDKConfiguration!
    var container: Container? = nil
        
    private init() {
        CappingManager._shared = CappingManager()
    }
    
    public func setup(_ configurationID: String?, completionHandler completion: ((Result<Container, AdsNetworkSDKError>) -> Void)? = nil) {
        lock.lock()
        defer { lock.unlock() }
        
        if CappingManager.shared.isBlacklist {
            Log.assertionFailure("AicactusAdsNetwork couldn't be initialized. Client is in blacklist.")
            return
        }
         
        var cid: String!
        if configurationID == nil {
            let config = Bundle.main.infoDictionary?["Aicactus SDK Config"] as? [String: String]
            guard let configurationIDFromSetup = config?["configurationID"] else {
                Log.assertionFailure("AicactusAdsNetwork couldn't be initialized. Please recheck your app config.")
                return
            }
            cid = configurationIDFromSetup
        } else {
            cid = configurationID!
        }
        
        guard cid != nil else { return }
        
        sdkConfiguration = SDKConfiguration(configurationID: cid)
        Session._shared = Session(configuration: sdkConfiguration)
        CoreApiClient.initContainer(configurationID: cid) { result in
            switch result {
            case .success(let container):
                self.container = container
                self.container?.configurationID = cid
                CappingManager.shared.config = container.capping
            case .failure(_):
                print("Failed to init container")
            }
            completion?(result)
        }
    }
}
