import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class ConnectivityController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  RxBool isOnline = true.obs;
  late StreamSubscription<List<ConnectivityResult>> _subscription;

  @override
  void onInit() {
    super.onInit();
    _checkInitialConnection();
    _subscription = _connectivity.onConnectivityChanged.listen((resultList) {
      if (resultList.isNotEmpty) {
        _updateConnectionStatus(resultList);
      }
    });
  }

  Future<void> _checkInitialConnection() async {
    try {
      final result = await _connectivity.checkConnectivity();
      _updateConnectionStatus(result);
    } catch (e) {
      print('Error checking initial connection: $e');
      isOnline.value = false;
    }
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    // Consider connected if any of the connectivity types is available
    final newStatus = results.any((result) => result != ConnectivityResult.none);

    if (isOnline.value != newStatus) {
      isOnline.value = newStatus;

      if (newStatus) {
        _onInternetReconnect();
      } else {
        _onInternetLost();
      }
    }
  }

  void _onInternetReconnect() {
    print("✅ Internet is back. Syncing...");
    Get.snackbar(
      "Online",
      "Internet connection restored ${isOnline.value}",
      snackPosition: SnackPosition.TOP,
    );
    // Place your sync logic here
  }

  void _onInternetLost() {
    print("❌ Internet connection lost.");
    Get.snackbar(
      "Offline",
      "No internet connection  ${isOnline.value}",
      snackPosition: SnackPosition.TOP,
    );
  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }
}