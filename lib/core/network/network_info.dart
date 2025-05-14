import 'dart:async';
import 'dart:developer' as developer;
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
    try {
      // For web platform, always return true since InternetConnectionChecker doesn't support web
      if (kIsWeb) {
        developer.log(
          'Running on web platform, assuming network connection is available',
        );
        return true;
      }

      // For mobile platforms, use the connection checker
      if (connectionChecker != null) {
        final hasConnection = await connectionChecker!.hasConnection;
        developer.log('Network connection check result: $hasConnection');
        return hasConnection;
      }

      // Default fallback
      developer.log(
        'No connection checker available, assuming network is available',
      );
      return true;
    } catch (e) {
      developer.log('Error checking network connection: $e');
      // In case of error, assume network is available to prevent app from failing
      return true;
    }
  }
}
