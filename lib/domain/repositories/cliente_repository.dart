import 'package:dartz/dartz.dart';
import '../entities/cliente.dart';
import '../../core/errors/failures.dart';

abstract class ClienteRepository {
  Future<Either<Failure, List<Cliente>>> getClientes();
  Future<Either<Failure, Cliente>> createCliente(Cliente cliente);
}
