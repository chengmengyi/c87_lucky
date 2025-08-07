import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:lucky_base/lucky_dialog/no_network_dialog/no_network_dialog.dart';
import 'package:lucky_base/lucky_routers/lucky_routers.dart';

class NetworkUtils {
  static final NetworkUtils _networkUtils=NetworkUtils();
  static NetworkUtils get instance => _networkUtils;
  StreamSubscription<List<ConnectivityResult>>? subscription;

  initListener(){
    subscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      if(result.contains(ConnectivityResult.none)){
        LuckyRouters.instance.showDialog(child: NoNetworkDialog());
      }
    });
  }

  dispose(){
    subscription?.cancel();
  }
}