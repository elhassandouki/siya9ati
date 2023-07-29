import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdHelper {
  static BannerAd bannerQuiz = BannerAd(
    // adUnitId: 'ca-app-pub-3940256099942544/6300978111',
    adUnitId: 'ca-app-pub-8728082287481293/3662993661',
    size: AdSize.banner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );
  static BannerAd bannerQuiz2 = BannerAd(
    // adUnitId: 'ca-app-pub-3940256099942544/6300978111',
    adUnitId: 'ca-app-pub-8728082287481293/2046659666',
    size: AdSize.banner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );
  static BannerAd bannerCour = BannerAd(
    //adUnitId: 'ca-app-pub-3940256099942544/6300978111',
    adUnitId: 'ca-app-pub-8728082287481293/5678265996',
    size: AdSize.banner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );
  static BannerAd bannerCour2 = BannerAd(
    //adUnitId: 'ca-app-pub-3940256099942544/6300978111',
    adUnitId: 'ca-app-pub-8728082287481293/9733577993',
    size: AdSize.banner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );
  static BannerAd bannerSignal = BannerAd(
    //adUnitId: 'ca-app-pub-3940256099942544/6300978111',
    adUnitId: 'ca-app-pub-8728082287481293/1355877607',
    size: AdSize.banner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );
  static BannerAd bannerSignal2 = BannerAd(
    //adUnitId: 'ca-app-pub-3940256099942544/6300978111',
    adUnitId: 'ca-app-pub-8728082287481293/6488467550',
    size: AdSize.banner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );
  static BannerAd bannerMawa9if = BannerAd(
    //adUnitId: 'ca-app-pub-3940256099942544/6300978111',
    adUnitId: 'ca-app-pub-8728082287481293/6225060900',
    size: AdSize.banner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );
  static BannerAd bannerModawana = BannerAd(
    //adUnitId: 'ca-app-pub-3940256099942544/6300978111',
    adUnitId: 'ca-app-pub-8728082287481293/5076147688',
    size: AdSize.banner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );
  static BannerAd bannerModawana2 = BannerAd(
    adUnitId: 'ca-app-pub-8728082287481293/4096170139',
    //adUnitId: 'ca-app-pub-3940256099942544/6300978111',
    size: AdSize.banner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );
  static BannerAd bannerMokhalafa = BannerAd(
    //adUnitId: 'ca-app-pub-3940256099942544/6300978111',
    adUnitId: 'ca-app-pub-8728082287481293/5217680119',
    size: AdSize.banner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );
  static BannerAd bannerMokhalafa2 = BannerAd(
    //adUnitId: 'ca-app-pub-3940256099942544/6300978111',
    adUnitId: 'ca-app-pub-8728082287481293/7460700074',
    size: AdSize.banner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );
  static BannerAd bannerQuestion = BannerAd(
    //adUnitId: 'ca-app-pub-3940256099942544/6300978111',
    adUnitId: 'ca-app-pub-8728082287481293/9895291727',
    size: AdSize.banner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );
  static BannerAd bannerMohim = BannerAd(
    //adUnitId: 'ca-app-pub-3940256099942544/6300978111',
    adUnitId: 'ca-app-pub-8728082287481293/8199066671',
    size: AdSize.banner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );
  static BannerAd bannerMohim2 = BannerAd(
    //adUnitId: 'ca-app-pub-3940256099942544/6300978111',
    adUnitId: 'ca-app-pub-8728082287481293/1140772107',
    size: AdSize.banner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );

  static String get interQuiz {
    if (Platform.isAndroid) {
      //return "ca-app-pub-3940256099942544/1033173712";
      return "ca-app-pub-8728082287481293/2574107420";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get interCour {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/1033173712";
      //return "ca-app-pub-8728082287481293/7251719038";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get interdCour {
    if (Platform.isAndroid) {
      //return "ca-app-pub-3940256099942544/1033173712";
      return "ca-app-pub-8728082287481293/8181657320";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get interSignal {
    if (Platform.isAndroid) {
      //return "ca-app-pub-3940256099942544/1033173712";
      return "ca-app-pub-8728082287481293/3563238546";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get interMawa9if {
    if (Platform.isAndroid) {
      //return "ca-app-pub-3940256099942544/1033173712";
      return "ca-app-pub-8728082287481293/6502841629";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get interModawana {
    if (Platform.isAndroid) {
      //return "ca-app-pub-3940256099942544/1033173712";
      return "ca-app-pub-8728082287481293/7140038390";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get interMokhalafa {
    if (Platform.isAndroid) {
      //return "ca-app-pub-3940256099942544/1033173712";
      return "ca-app-pub-8728082287481293/7175180494";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get interQuestion {
    if (Platform.isAndroid) {
      //return "ca-app-pub-3940256099942544/1033173712";
      return "ca-app-pub-8728082287481293/3493534901";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get interMohim {
    if (Platform.isAndroid) {
      //return "ca-app-pub-3940256099942544/1033173712";
      return "ca-app-pub-8728082287481293/1696140020";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}
