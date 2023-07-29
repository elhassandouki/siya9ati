import 'package:google_mobile_ads/google_mobile_ads.dart';
//import 'admob.dart';

class InterAds {
  InterstitialAd? _interstitialAd;
  int maxFailedLoadAttempts = 3;
  int _numInterstitialLoadAttempts = 0;
  late String Interstitial;

  //// ads inter
  void createInterstitialAd(Interstitial) {
    InterstitialAd.load(
        adUnitId: Interstitial,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            // print('$ad loaded');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts <= maxFailedLoadAttempts) {
              createInterstitialAd(Interstitial);
            }
          },
        ));
  }

  void showInterstitialAd() {
    //_isloaded = true;
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createInterstitialAd(Interstitial);
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createInterstitialAd(Interstitial);
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }
}
