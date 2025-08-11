import 'package:flutter/services.dart';

//TODO:修改所有的函数名
final class Feng {
  static final Feng instance = Feng._internal();

  Feng._internal();

  final _methodChannel = const MethodChannel('feng');

  //设备是否被Root
  Future<bool> roScratchot() async {
    return (await _methodChannel.invokeMethod("roScratchot")) == true;
  }

  //是否连接VPN网络
  Future<bool> vpScratchn() async {
    return (await _methodChannel.invokeMethod("vpScratchn")) == true;
  }

  //设备是否有可用的sim卡
  Future<bool> siScratchm() async {
    return (await _methodChannel.invokeMethod("siScratchm")) == true;
  }

  //设备是否为模拟器
  Future<bool> simulScratchator() async {
    return (await _methodChannel.invokeMethod("simulScratchator")) == true;
  }

  //应用是否安装自Google play store
  Future<bool> stScratchore() async {
    return (await _methodChannel.invokeMethod("stScratchore")) == true;
  }

  //设备是否启用开发者模式
  Future<bool> develScratchoper() async {
    return (await _methodChannel.invokeMethod("develScratchoper")) == true;
  }

  //安装应用的安装器程序的包名
  Future<String> instaScratchller() async {
    return await _methodChannel.invokeMethod("instaScratchller");
  }

  //初始化数盟平台
  Future<void> initNumbScratcherUnit({required String apiKey}) async {
    await _methodChannel.invokeMethod("initNumbScratcherUnit", apiKey);
  }

  //从数盟平台读取数盟可信ID，对应文档请求参数：did
  Future<String> getNuScratchmberUnitID({String channel = "", String message = ""}) async {
    return (await _methodChannel.invokeMethod("getNuScratchmberUnitID", {
          "channel": channel,
          "message": message,
        })) ??
        "";
  }
}
