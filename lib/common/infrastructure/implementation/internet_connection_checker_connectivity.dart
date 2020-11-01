import 'package:connectivity/connectivity.dart';

import '../internet_connection_checker.dart';

class InternetConnectionCheckerConnectivity extends InternetConnectionChecker {
  @override
  Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    return connectivityResult != ConnectivityResult.none;
  }
}
