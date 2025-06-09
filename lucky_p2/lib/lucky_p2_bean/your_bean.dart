class YourBean{
  String content;
  int reward;
  bool win;
  int play7Num;
  bool is9;
  bool isKey;
  YourBean({
    required this.content,
    required this.reward,
    required this.win,
    this.play7Num=0,
    this.is9=false,
    this.isKey=false,
});

  @override
  String toString() {
    return 'YourBean{content: $content, reward: $reward, win: $win}';
  }
}