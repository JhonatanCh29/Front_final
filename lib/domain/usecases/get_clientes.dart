import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/cliente.dart';
import '../repositories/cliente_repository.dart';

class GetClientes {
  final ClienteRepository repository;

  GetClientes(this.repository);

  Future<Either<Failure, List<Cliente>>> call() async {
    return await repository.getClientes();
  }
}
