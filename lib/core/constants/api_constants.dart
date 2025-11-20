class ApiConstants {
  // Base URL del backend Spring Boot
  // Emulador Android usa 10.0.2.2 (representa el host machine)
  static const String baseUrl = 'http://10.0.2.2:8080';

  // Endpoints (sin barra inicial porque baseUrl ya no tiene barra final)
  static const String pedidosEndpoint = '/api/pedido';
  static const String clientesEndpoint = '/api/cliente';
  static const String platosEndpoint = '/api/plato';

  // Headers
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Timeouts
  static const int connectionTimeout = 30000;
  static const int receiveTimeout = 30000;
}
