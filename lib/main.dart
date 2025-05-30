import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lucky_base/lucky_utils/app_lifecycle_utils.dart';
import 'package:lucky_base/lucky_utils/lucky_ad_utils.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_p1/lucky_p1_routers/lucky_p1_routers.dart';
import 'package:lucky_p2/lucky_p2_routers/lucky_p2_routers.dart';
import 'package:scratch_it_lucky/main/main_page.dart';
import 'package:lucky_p1/lucky_p1_util/play_info_utils.dart' as p1PlayUtils;

void main() {
  _initBase();
  _initP1();
  runApp(const MyApp());
}

_initBase()async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarDividerColor: null,
        statusBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
      )
  );
  await GetStorage.init();
  AppLifecycleUtils.instance.init();
}

_initP1()async{
  p1PlayUtils.PlayInfoUtils.instance.initPlayList();
  p1PlayUtils.PlayInfoUtils.instance.resetPlayTime();
  LuckyAdUtils.instance.initAd();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var mainRouterName="/main";
    var mainList=[
      GetPage(
        name: mainRouterName,
        page: ()=> MainPage(),
        transition: Transition.fadeIn,
      ),
    ];
    var list=mainList+LuckyP1RouterList.list+LuckyP2RouterList.list;
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (c,child)=>GetMaterialApp(
        title: 'ScratchItLucky',
        enableLog: true,
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.system,
        initialRoute: mainRouterName,
        debugShowCheckedModeBanner: false,
        getPages: list,
        defaultTransition: Transition.rightToLeft,
        builder: (context,widget){
          return  MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget!,
          );
        },
      ),
    );
  }
}
