class ServerException implements Exception {
  final String message;
  
  ServerException([this.message = 'Error del servidor']);
}

class ConnectionException implements Exception {
  final String message;
  
  ConnectionException([this.message = 'Error de conexión']);
}

class ValidationException implements Exception {
  final String message;
  final Map<String, String>? errors;
  
  ValidationException({
    this.message = 'Error de validación',
    this.errors,
  });
}

class NotFoundException implements Exception {
  final String message;
  
  NotFoundException([this.message = 'Recurso no encontrado']);
}
