abstract class Failure {
  final String message;
  
  const Failure(this.message);
}

// Error del servidor (500)
class ServerFailure extends Failure {
  const ServerFailure([String message = 'Error interno del servidor']) : super(message);
}

// Error de conexión (no hay internet o servidor no disponible)
class ConnectionFailure extends Failure {
  const ConnectionFailure([String message = 'No se pudo conectar con el servidor']) : super(message);
}

// Error de validación (400)
class ValidationFailure extends Failure {
  final Map<String, String>? errors;
  
  const ValidationFailure({
    String message = 'Error de validación',
    this.errors,
  }) : super(message);
}

// Recurso no encontrado (404)
class NotFoundFailure extends Failure {
  const NotFoundFailure([String message = 'Recurso no encontrado']) : super(message);
}

// Error general
class GeneralFailure extends Failure {
  const GeneralFailure([String message = 'Ha ocurrido un error']) : super(message);
}
