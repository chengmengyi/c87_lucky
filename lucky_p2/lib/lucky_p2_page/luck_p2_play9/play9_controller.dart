import 'dart:math';

import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_p2/lucky_p2_bean/your_bean.dart';
import 'package:lucky_p2/lucky_p2_util/play_info_utils.dart';
import 'package:lucky_p2/lucky_p2_util/play_utils.dart';
import 'package:lucky_p2/lucky_p2_util/value_utils.dart';

class Play9Controller extends LuckyBaseController with GetTickerProviderStateMixin{
  PlayUtils playUtils=PlayUtils(PlayType.card9);
  final random = Random();
  var elements = ["play94", "play95", "play96"];

  var winningLines = [
    [0, 1, 2], // 行
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6], // 列
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8], // 对角线
    [2, 4, 6],
  ];


  @override
  void onReady() {
    super.onReady();
    playUtils.initPlay(this);
    _initYourList();
  }

  clickRevealAll(){
    playUtils.startAutoScratch(
      offsetCallback: (offset){

      }
    );
  }

  onThreshold(){
    playUtils.onThreshold(
      resetCallback: (){
        _initYourList();
      }
    );
  }

  _initYourList(){
    var list = generateGrid(forceWin: ValueUtils.instance.getPlay9Point());
    playUtils.setYourList(list);
    update(["your_widget"]);
  }

  /// 检查是否某个元素形成了一条线
  bool hasWinningLine(List<YourBean> board, String target) {
    for (var line in winningLines) {
      if (line.every((i) => board[i].content == target)) return true;
    }
    return false;
  }

  /// 检查是否任何元素形成了一条线
  bool anyLineExists(List<YourBean> board) {
    for (var e in elements) {
      if (hasWinningLine(board, e)) return true;
    }
    return false;
  }

  /// 生成满足条件的3x3列表
  List<YourBean> generateGrid({required bool forceWin}) {
    while (true) {
      List<YourBean> board = List.filled(9, YourBean(content: "", reward: 0, win: false));

      if (forceWin) {
        // 1. 随机选择一个 winningLine 让 play94 占据
        var line = winningLines.random();
        for (var i in line) {
          board[i] = YourBean(content: "play94", reward: ValueUtils.instance.getPlay9Reward(), win: true);
        }

        // 2. 剩余格子用 play95/play96 随机填
        for (int i = 0; i < 9; i++) {
          if (board[i].content.isEmpty) {
            board[i] = YourBean(content: random.nextBool() ? "play95" : "play96", reward: ValueUtils.instance.getPlay9Reward(), win: false);
          }
        }

        // 3. 确保 play95/96 没有组成其他线
        if (!hasWinningLine(board, "play95") && !hasWinningLine(board, "play96")) {
          return board;
        }

      } else {
        // 不满足条件：所有格子随机填，但不能有一条线
        for (int i = 0; i < 9; i++) {
          board[i] = YourBean(content: elements.random(), reward: ValueUtils.instance.getPlay9Reward(), win: false);
        }

        if (!anyLineExists(board)) return board;
      }
    }
  }


  @override
  void onClose() {
    playUtils.onClose();
    super.onClose();
  }
}