import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_p1/lucky_p1_page/luck_p1_play1/play1_page.dart';
import 'package:lucky_p1/lucky_p1_page/luck_p1_play2/play2_page.dart';
import 'package:lucky_p1/lucky_p1_page/luck_p1_play3/play3_page.dart';
import 'package:lucky_p1/lucky_p1_page/luck_p1_play4/play4_page.dart';
import 'package:lucky_p1/lucky_p1_page/luck_p1_play5/play5_page.dart';
import 'package:lucky_p1/lucky_p1_page/luck_p1_play6/play6_page.dart';
import 'package:lucky_p1/lucky_p1_page/luck_p1_play7/play7_page.dart';
import 'package:lucky_p1/lucky_p1_page/luck_p1_play8/play8_page.dart';
import 'package:lucky_p1/lucky_p1_page/luck_p1_play9/play9_page.dart';
import 'package:lucky_p1/lucky_p1_page/lucky_p1_home/home_page.dart';
import 'package:lucky_p1/lucky_p1_page/lucky_web/web_page.dart';

class LuckyP1RoutersName{
  static const home="/luckyP1/home";
  static const play1="/luckyP1/play1";
  static const play2="/luckyP1/play2";
  static const play3="/luckyP1/play3";
  static const play4="/luckyP1/play4";
  static const play5="/luckyP1/play5";
  static const play6="/luckyP1/play6";
  static const play7="/luckyP1/play7";
  static const play8="/luckyP1/play8";
  static const play9="/luckyP1/play9";
  static const web="/luckyP1/web";
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
    GetPage(
      name: LuckyP1RoutersName.play2,
      page: ()=> Play2Page(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: LuckyP1RoutersName.play3,
      page: ()=> Play3Page(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: LuckyP1RoutersName.play4,
      page: ()=> Play4Page(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: LuckyP1RoutersName.play5,
      page: ()=> Play5Page(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: LuckyP1RoutersName.play6,
      page: ()=> Play6Page(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: LuckyP1RoutersName.play7,
      page: ()=> Play7Page(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: LuckyP1RoutersName.play8,
      page: ()=> Play8Page(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: LuckyP1RoutersName.play9,
      page: ()=> Play9Page(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: LuckyP1RoutersName.web,
      page: ()=> WebPage(),
      transition: Transition.fadeIn,
    ),
  ];
}