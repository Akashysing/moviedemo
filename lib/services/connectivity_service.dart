import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ConnectivityService extends GetxService {
  InternetConnectionCheckerPlus _checker = InternetConnectionCheckerPlus();

  final RxBool _isConnected = true.obs;
  bool get isConnected => _isConnected.value;

  @override
  Future<void> onInit() async {
    _checker = InternetConnectionCheckerPlus();
    checkInitialConnection();
    super.onInit();
  }

  void _startMonitoring() async {
    _checker.onStatusChange.listen((status) {
      if (status == InternetConnectionStatus.connected) {
        _isConnected(true);
      } else {
        _isConnected(false);
      }
    });
  }

  // Future<bool> checkConnection() async {
  //   await _checker.hasConnection.then((bool value) {
  //     _isConnected(value);
  //   });
  //   return _isConnected.value;
  // }

  Future<void> checkInitialConnection() async {
    await _checker.hasConnection.then((bool value) {
      _isConnected(value);
    });
    _startMonitoring();
  }
}
