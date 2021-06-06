import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

class ConnectivityState extends Equatable {
  final ConnectivityResult connectivity;

  ConnectivityState({this.connectivity = ConnectivityResult.none});

  factory ConnectivityState.initial() {
    return ConnectivityState();
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [connectivity];
}
