import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_p1/lucky_p1_page/luck_p1_play1/play1_page.dart';
import 'package:lucky_p1/lucky_p1_page/lucky_p1_home/home_page.dart';

class LuckyP1RoutersName{
  static const home="/luckyP1/home";
  static const play1="/luckyP1/play1";
}

class LuckyP1RouterList{
  static List<GetPage> list=[
    GetPage(
      name: LuckyP1RoutersName.home,
      page: ()=> HomePage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: LuckyP1RoutersName.play1,
      page: ()=> Play1Page(),
      transition: Transition.fadeIn,
    ),
  ];
}