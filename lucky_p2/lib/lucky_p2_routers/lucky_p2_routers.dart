import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_p2/lucky_p2_page/luck_p2_play1/play1_page.dart';
import 'package:lucky_p2/lucky_p2_page/luck_p2_play2/play2_page.dart';
import 'package:lucky_p2/lucky_p2_page/luck_p2_play3/play3_page.dart';
import 'package:lucky_p2/lucky_p2_page/luck_p2_play4/play4_page.dart';
import 'package:lucky_p2/lucky_p2_page/luck_p2_play5/play5_page.dart';
import 'package:lucky_p2/lucky_p2_page/luck_p2_play6/play6_page.dart';
import 'package:lucky_p2/lucky_p2_page/luck_p2_play7/play7_page.dart';
import 'package:lucky_p2/lucky_p2_page/luck_p2_play8/play8_page.dart';
import 'package:lucky_p2/lucky_p2_page/luck_p2_play9/play9_page.dart';
import 'package:lucky_p2/lucky_p2_page/lucky_p2_home/home_page.dart';
import 'package:lucky_p2/lucky_p2_page/lucky_web/web_page.dart';

class LuckyP2RoutersName{
  static const home="/luckyP2/home";
  static const play1="/luckyP2/play1";
  static const play2="/luckyP2/play2";
  static const play3="/luckyP2/play3";
  static const play4="/luckyP2/play4";
  static const play5="/luckyP2/play5";
  static const play6="/luckyP2/play6";
  static const play7="/luckyP2/play7";
  static const play8="/luckyP2/play8";
  static const play9="/luckyP2/play9";
  static const web="/luckyP2/web";
}

class LuckyP2RouterList{
  static List<GetPage> list=[
    GetPage(
      name: LuckyP2RoutersName.home,
      page: ()=> HomePage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: LuckyP2RoutersName.play1,
      page: ()=> Play1Page(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: LuckyP2RoutersName.play2,
      page: ()=> Play2Page(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: LuckyP2RoutersName.play3,
      page: ()=> Play3Page(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: LuckyP2RoutersName.play4,
      page: ()=> Play4Page(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: LuckyP2RoutersName.play5,
      page: ()=> Play5Page(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: LuckyP2RoutersName.play6,
      page: ()=> Play6Page(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: LuckyP2RoutersName.play7,
      page: ()=> Play7Page(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: LuckyP2RoutersName.play8,
      page: ()=> Play8Page(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: LuckyP2RoutersName.play9,
      page: ()=> Play9Page(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: LuckyP2RoutersName.web,
      page: ()=> WebPage(),
      transition: Transition.fadeIn,
    ),
  ];
}