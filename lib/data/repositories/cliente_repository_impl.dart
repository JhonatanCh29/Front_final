import 'package:dartz/dartz.dart';
import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/cliente.dart';
import '../../domain/repositories/cliente_repository.dart';
import '../datasources/cliente_remote_data_source.dart';
import '../models/cliente_model.dart';

class ClienteRepositoryImpl implements ClienteRepository {
  final ClienteRemoteDataSource remoteDataSource;

  ClienteRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Cliente>>> getClientes() async {
    try {
      final clientes = await remoteDataSource.getClientes();
      return Right(clientes);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on ConnectionException catch (e) {
      return Left(ConnectionFailure(e.message));
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Cliente>> createCliente(Cliente cliente) async {
    try {
      final clienteModel = ClienteModel.fromEntity(cliente);
      final createdCliente = await remoteDataSource.createCliente(clienteModel);
      return Right(createdCliente);
    } on ValidationException catch (e) {
      return Left(ValidationFailure(message: e.message, errors: e.errors));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on ConnectionException catch (e) {
      return Left(ConnectionFailure(e.message));
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
}
