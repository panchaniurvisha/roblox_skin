import google_mobile_ads

import UIKit

class SingisticNativeAdFactory : FLTNativeAdFactory {

    func createNativeAd(_ nativeAd: GADNativeAd,
                        customOptions: [AnyHashable : Any]? = nil) -> GADNativeAdView? {
        let nibView = Bundle.main.loadNibNamed("NativeAdView", owner: nil, options: nil)!.first


        let nativeAdView = nibView as! GADNativeAdView

        (nativeAdView.headlineView as! UILabel).text = nativeAd.headline
        nativeAdView.headlineView!.isHidden = nativeAd.headline == nil


        (nativeAdView.bodyView as! UILabel).text = nativeAd.body
        nativeAdView.bodyView!.isHidden = nativeAd.body == nil

        (nativeAdView.callToActionView as! UIButton).setTitle(nativeAd.callToAction, for: .normal)
        nativeAdView.callToActionView!.isHidden = nativeAd.callToAction == nil

        (nativeAdView.iconView as! UIImageView).image = nativeAd.icon?.image
        nativeAdView.iconView!.isHidden = nativeAd.icon == nil

        (nativeAdView.storeView as! UILabel).text = nativeAd.store
        nativeAdView.storeView!.isHidden = nativeAd.store == nil

        (nativeAdView.priceView as! UILabel).text = nativeAd.price
        nativeAdView.priceView!.isHidden = nativeAd.price == nil

        (nativeAdView.advertiserView as! UILabel).text = nativeAd.advertiser
        nativeAdView.advertiserView!.isHidden = nativeAd.advertiser == nil

        nativeAdView.callToActionView?.isUserInteractionEnabled = false

        nativeAdView.nativeAd = nativeAd

        return nativeAdView
    }
}