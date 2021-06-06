import 'dart:async';

import 'package:authentication_riverpod/controlers/connectivity/connectivity_state.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final providerConnectivityController = StateNotifierProvider<ConnectivityController, ConnectivityState>(
  (ref) => ConnectivityController(ref.read),
);

class ConnectivityController extends StateNotifier<ConnectivityState> {
  final Reader _read;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult?> _connectivitySubscription;

  ConnectivityController(this._read) : super(ConnectivityState.initial()) {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((connectivity) {
      state = ConnectivityState(connectivity: connectivity);
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
}
