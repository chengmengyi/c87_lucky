class YourBean{
  String content;
  int reward;
  bool win;
  YourBean({
    required this.content,
    required this.reward,
    required this.win,
});

  @override
  String toString() {
    return 'YourBean{content: $content, reward: $reward, win: $win}';
  }
}