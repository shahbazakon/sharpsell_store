import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker? connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected async {
    // For web platform, always return true since InternetConnectionChecker doesn't support web
    if (kIsWeb) {
      return true;
    }

    // For mobile platforms, use the connection checker
    if (connectionChecker != null) {
      return await connectionChecker!.hasConnection;
    }

    // Default fallback
    return true;
  }
}
