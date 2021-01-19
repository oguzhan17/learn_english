import 'package:firebase_admob/firebase_admob.dart';

class AdvertService{
  static final AdvertService _instance = AdvertService._internal();
  factory AdvertService()=> _instance;
  MobileAdTargetingInfo _targetingInfo;
  final String _bannerAd = 'ca-app-pub-1675144193679806/9950588586';

  AdvertService._internal(){
    _targetingInfo = MobileAdTargetingInfo();
  }

  showBanner(){
    BannerAd banner = BannerAd(
        adUnitId: _bannerAd,
        size: AdSize.fullBanner,
        targetingInfo: _targetingInfo);

    banner
    ..load()
    ..show();
    banner.dispose();
  }
}