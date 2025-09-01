import 'dart:math';

import 'package:lucky_base/lucky_base/lucky_base_controller.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_p2/lucky_p2_bean/win_reward_bean.dart';
import 'package:lucky_p2/lucky_p2_bean/your_bean.dart';
import 'package:lucky_p2/lucky_p2_util/play_info_utils.dart';
import 'package:lucky_p2/lucky_p2_util/play_utils.dart';
import 'package:lucky_p2/lucky_p2_util/utils.dart';
import 'package:lucky_p2/lucky_p2_util/value_utils.dart';

class Play2Controller extends LuckyBaseController with GetTickerProviderStateMixin{
  PlayUtils playUtils=PlayUtils(PlayType.card2);
  List<List<int>> horizontalLines = [
    [0, 1, 2], // 第1行
    [3, 4, 5], // 第2行
    [6, 7, 8], // 第3行
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
      },
      refreshKey: (){
        update(["your_widget"]);
      },
    );
  }

  _initYourList(){
    var list = generateGrid();
    playUtils.setYourList(list);
    update(["your_widget"]);
  }

  List<YourBean> generateGrid() {
    final List<String> options = ["play24", "play25", "play26"];
    final Random rand = Random();
    var winnerBean = ValueUtils.instance.getWinnerBean(playUtils.playType);
    while (true) {
      List<YourBean> grid = List.filled(9, YourBean(content: "", reward: 0, win: false));

      if (winnerBean.winNum>0) {
        // 1. 随机选择一个中奖横线
        int winLineIndex = rand.nextInt(3);
        List<int> winLine = horizontalLines[winLineIndex];
        String winValue = options[rand.nextInt(options.length)];
        // 设置这条横线为中奖值
        for (int index in winLine) {
          if(winnerBean.winType==WinType.diamond&&index==winLine.first){
            grid[index] = YourBean(content: winValue, reward: winnerBean.coinsNum, win: true,isKey: true);
          }else{
            grid[index] = YourBean(content: winValue, reward: winnerBean.coinsNum, win: true);
          }
        }

        // 2. 给其他两行填入非三连的值
        for (int i = 0; i < 3; i++) {
          if (i == winLineIndex) continue;
          List<int> line = horizontalLines[i];
          while (true) {
            // 尝试填入随机值
            List<String> values = List.generate(3, (_) => options[rand.nextInt(options.length)]);
            // 如果不是三连才使用
            if (!(values[0] == values[1] && values[1] == values[2])) {
              for (int j = 0; j < 3; j++) {
                grid[line[j]] = YourBean(content: values[j], reward: ValueUtils.instance.getRandomRewardByMax(), win: false);
              }
              break;
            }
          }
        }

        // 最终校验确保只有一个三连横线
        int winCount = horizontalLines.where((line) =>
        grid[line[0]].content == grid[line[1]].content &&
            grid[line[1]].content == grid[line[2]].content
        ).length;

        if (winCount == 1) return grid;
      } else {
        // 所有三行都不三连
        for (int i = 0; i < 3; i++) {
          List<int> line = horizontalLines[i];
          while (true) {
            List<String> values = List.generate(3, (_) => options[rand.nextInt(options.length)]);
            if (!(values[0] == values[1] && values[1] == values[2])) {
              for (int j = 0; j < 3; j++) {
                grid[line[j]] = YourBean(content: values[j], reward: ValueUtils.instance.getRandomRewardByMax(), win: false);
              }
              break;
            }
          }
        }

        // 验证完全无横向三连
        bool hasLine = horizontalLines.any((line) =>
        grid[line[0]].content == grid[line[1]].content &&
            grid[line[1]].content == grid[line[2]].content
        );

        if (!hasLine) return grid;
      }
    }
  }

  String getLeftReward(List<YourBean> list){
    if(list.indexWhere((value)=>value.isKey)>=0){
      return "+1";
    }
    var reward = list.fold(0.0, (previousValue, element) => addTwoNums(previousValue, element.reward));
    return "${getMoneySymbol()}${getMoneyByCountry(reward)}";
  }

  @override
  void onClose() {
    playUtils.onClose();
    super.onClose();
  }
}