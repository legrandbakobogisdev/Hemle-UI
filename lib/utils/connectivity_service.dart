import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ConnectivityService {
  static final InternetConnection _connection = InternetConnection();

  // Vérifier l'état actuel
  static Future<bool> get isConnected => _connection.hasInternetAccess;

  // Écouter les changements de connexion
  static Stream<InternetStatus> get onStatusChange => _connection.onStatusChange;

  // Écouter les changements booléens (connecté/déconnecté)
  static Stream<bool> get onConnectionChange =>
      _connection.onStatusChange.map((status) => status == InternetStatus.connected);
}