abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> get isConnected async {
    // In a real app, we would use a connectivity package
    // For this demo, we'll assume we're always connected
    return true;
  }
}
