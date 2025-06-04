enum WinType{
  coins,diamond,
}

class WinRewardBean{
  int winNum;
  int bigWin;
  double coinsNum;
  int rewardNormal;
  WinType winType;

  WinRewardBean({
    required this.winNum,
    required this.bigWin,
    required this.coinsNum,
    required this.winType,
    required this.rewardNormal,
  });

  @override
  String toString() {
    return 'WinnerBackBean{winNum: $winNum, bigWin: $bigWin, coinsNum: $coinsNum, winType: $winType}';
  }
}