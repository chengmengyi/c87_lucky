class LuckyAdUtils{
  static final LuckyAdUtils _instance = LuckyAdUtils();
  static LuckyAdUtils get instance => _instance;

  showP1Ad({
    required Function() closeAd,
}){
    closeAd.call();
  }
}