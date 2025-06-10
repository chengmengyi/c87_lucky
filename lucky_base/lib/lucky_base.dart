
import 'lucky_base_platform_interface.dart';

class LuckyBase {
  static final LuckyBase _instance = LuckyBase();
  static LuckyBase get instance => _instance;
  //a包调用
  func1(){
    LuckyBasePlatform.instance.func1();
  }
  //b包调用
  func2(){
    LuckyBasePlatform.instance.func2();
  }
  //b包调用
  func3(){
    LuckyBasePlatform.instance.func3();
  }
  //跳h5
  func4(){
    LuckyBasePlatform.instance.func4();
  }
}
