# AicactusAdsNetwork

[![Version](https://img.shields.io/cocoapods/v/AicactusAdsNetwork.svg?style=flat)](https://cocoapods.org/pods/AicactusAdsNetwork)
[![License](https://img.shields.io/cocoapods/l/AicactusAdsNetwork.svg?style=flat)](https://cocoapods.org/pods/AicactusAdsNetwork)
[![Platform](https://img.shields.io/cocoapods/p/AicactusAdsNetwork.svg?style=flat)](https://cocoapods.org/pods/AicactusAdsNetwork)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

Go to Info.plist and replace your container ID or can pass as an argument to setup method

## Installation

AicactusAdsNetwork is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'AicactusAdsNetwork'
```

## Usage

### Init

#### From Info.plist

Add this code to Info.plist and replace your container ID

```xml
<key>Aicactus SDK Config</key>
<dict>
	<key>containerID</key>
	<string>YOUR CONTAINER ID</string>
</dict>
```
Then in code

```swift
import AicactusAdsNetwork


AicactusAdsNetwork.shared.setup()
```

#### Or setup from code directly

```swift
import AicactusAdsNetwork


AicactusAdsNetwork.shared.setup(<<<YOUR CONTAINER ID>>>)
```

### Banner Ad

```swift
// Create AdView with size and type is banner
let adView = AdView()
adView.adSize = .rectangle
adView.adType = .banner
adView.unitID = NSNumber(value: <<<Find your inventory ID in container>>>)

// Add AdView to your layout
self.view.addSubview(adView)

// Perform loadAd with a request
adView.loadAd(AdRequest())
```

### Video Ad

#### Load Ad VAST Tag Url

```swift
// Create AdView with size and type is video
let videoAdLoader = VideoAdLoader(adUnitID: <<<Find your inventory ID in container>>>, adSize: .video)

// Set delegate to retrieve data later
videoAdLoader.delegate = self

// Perform loadAd with a request
videoAdLoader.loadAd(AdRequest())

```

#### Using Native Player to player Content and Ad

Define your player in layout and connect IBOutlet in your ViewController
```swift
@IBOutlet weak var imaPlayer: IMAPlayerView!
```

Init player
```swift
override func viewDidLoad() {
    super.viewDidLoad()
    imaPlayer.setup(contentUrl: ContentURLString)
    imaPlayer.delegate = self
}
```

Request Ads
```swift
override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    imaPlayer.requestAds(adUnitID: 21)
}
```

Listen event video Ad loaded and perform playing

```swift
extension ViewController: IMAPlayerViewDelegate {
    func imaPlayerView(_ adsManager: ACIMAAdsManager, didReceive event: ACIMAAdEvent) {
        if event.type == ACIMAAdEventType.LOADED {
            adsManager.start()
        }
    }

    func imaPlayerView(_ adsManager: ACIMAAdsManager, didReceive error: ACIMAAdError) {
        imaPlayer.contentPlayer.play()
    }

    func imaPlayerViewDidRequestContentPause(_ adsManager: ACIMAAdsManager) {
        imaPlayer.contentPlayer.pause()
    }

    func imaPlayerViewDidRequestContentResume(_ adsManager: ACIMAAdsManager) {
        imaPlayer.contentPlayer.play()
    }

    func imaPlayerView(_ loader: ACIMAAdsLoader, adsLoadedWith adsLoadedData: ACIMAAdsLoadedData) {

    }

    func imaPlayerView(_ loader: ACIMAAdsLoader, failedWith adErrorData: ACIMAAdLoadingErrorData) {
        imaPlayer.contentPlayer.play()
    }
}
```

### Listen Ad Events

#### For Banner Ad - AdViewDelegate
```swift
extension ShowAdViewController: AdViewDelegate {
    func adView(_ adView: AdView, didFailLoad error: AdsNetworkSDKError) {
        print("Ad did fail to load with error: \(error.errorDescription ?? "Unknown")")
    }

    func adView(_ adView: AdView, didSuccessLoad bid: Bid) {
        print("Ad Loaded with bid id: \(bid.id)")
    }

	// Override click on Ad behavior
	func adView(_ adView: AdView, didClickAd url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true)
    }
}
```

#### For Video Ad - VideoAdLoaderDelegate
```swift
extension ShowAdViewController: VideoAdLoaderDelegate {
    func videoAdLoader(_ unitID: Int64, didSuccessLoad bid: Bid, vastTagURL url: String) {
        print("Video Ad Content URL: \(url)")
    }

    func videoAdLoader(_ unitID: Int64, didFailLoad error: AdsNetworkSDKError) {
        print("Video Ad did fail to load with error: \(error.errorDescription ?? "Unknown")")
    }
}
```

## Author

Aicactus, Si Huynh, tan-si.huynh@aicactus.io

## License

AicactusAdsNetwork is available under the MIT license. See the LICENSE file for more info.
