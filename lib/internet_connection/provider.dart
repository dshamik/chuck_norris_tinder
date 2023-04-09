import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectivityProvider extends Notifier<bool> {
  ConnectivityProvider() {
    final internetProvider = InternetConnectionChecker.createInstance(
      checkTimeout: const Duration(seconds: 2),
      checkInterval: const Duration(milliseconds: 400),
    );

    final StreamSubscription<InternetConnectionStatus> _ =
    internetProvider.onStatusChange.listen(
          (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            state = true;
            break;
          case InternetConnectionStatus.disconnected:
            state = false;
            break;
        }
      },
    );

    Connectivity().onConnectivityChanged.listen((result) async {
      state = await InternetConnectionChecker().hasConnection;
    });
  }

  @override
  bool build() {
    return false;
  }
}