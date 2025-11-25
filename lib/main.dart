import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lucky_base/lucky_utils/app_lifecycle_utils.dart';
import 'package:lucky_base/lucky_utils/check_af_utils.dart';
import 'package:lucky_base/lucky_utils/firebase_utils.dart';
import 'package:lucky_base/lucky_utils/language/language_translation.dart';
import 'package:lucky_base/lucky_utils/local_config.dart';
import 'package:lucky_base/lucky_utils/lucky_export.dart';
import 'package:lucky_base/lucky_utils/lucky_utils.dart';
import 'package:lucky_base/lucky_utils/tttt/tttt_utils.dart';
import 'package:lucky_p1/lucky_p1_routers/lucky_p1_routers.dart';
import 'package:lucky_p2/lucky_p2_routers/lucky_p2_routers.dart';
import 'package:scratch_it_lucky/main/main_page.dart';
import 'package:lucky_p1/lucky_p1_util/play_info_utils.dart' as p1PlayUtils;
import 'package:lucky_p2/lucky_p2_util/value_utils.dart' as p2ValueUtils;
import 'package:lucky_p2/lucky_p2_util/play_info_utils.dart' as p2PlayInfoUtils;
import 'package:firebase_core/firebase_core.dart';

void main() async{
  await _initBase();
  _initP1();
  _initP2();
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
  await Firebase.initializeApp();
  await Feng.instance.initNumbScratcherUnit(apiKey: encrypt(fengKongKey, 87));
  AppLifecycleUtils.instance.init();
}

_initP1()async{
  p1PlayUtils.PlayInfoUtils.instance.initPlayList();
  p1PlayUtils.PlayInfoUtils.instance.resetPlayTime();
}

_initP2()async{
  CheckAfUtils.instance.initAf();
  TTTTUtils.instance.install();
  TTTTUtils.instance.session();
  p2ValueUtils.ValueUtils.instance.initValue();
  p2PlayInfoUtils.PlayInfoUtils.instance.initPlayList();
  FirebaseUtils.instance.checkConnectivity();
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
        title: 'LuckyDashScratch',
        enableLog: true,
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.system,
        initialRoute: mainRouterName,
        debugShowCheckedModeBanner: false,
        getPages: list,
        defaultTransition: Transition.rightToLeft,
        translations: LanguageTranslation(),
        locale: Get.deviceLocale,
        fallbackLocale: const Locale("en", "US"),
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
