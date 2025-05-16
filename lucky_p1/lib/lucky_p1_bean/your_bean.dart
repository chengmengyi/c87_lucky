class YourBean{
  String content;
  int reward;
  bool win;
  int play7Num;
  YourBean({
    required this.content,
    required this.reward,
    required this.win,
    this.play7Num=0,
});

  @override
  String toString() {
    return 'YourBean{content: $content, reward: $reward, win: $win}';
  }
}