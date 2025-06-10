class YourBean{
  String content;
  double reward;
  bool win;
  int play7Num;
  bool is9;
  bool isKey;
  bool showKey;
  YourBean({
    required this.content,
    required this.reward,
    required this.win,
    this.play7Num=0,
    this.is9=false,
    this.isKey=false,
    this.showKey=true,
});

  @override
  String toString() {
    return 'YourBean{content: $content, reward: $reward, win: $win, play7Num: $play7Num, is9: $is9, isKey: $isKey, showKey: $showKey}';
  }
}