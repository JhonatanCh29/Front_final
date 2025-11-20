import 'package:dartz/dartz.dart';
import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/pedido.dart';
import '../../domain/repositories/pedido_repository.dart';
import '../datasources/pedido_remote_data_source.dart';
import '../models/pedido_model.dart';

class PedidoRepositoryImpl implements PedidoRepository {
  final PedidoRemoteDataSource remoteDataSource;

  PedidoRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Pedido>>> getPedidos() async {
    try {
      final pedidos = await remoteDataSource.getPedidos();
      return Right(pedidos);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on ConnectionException catch (e) {
      return Left(ConnectionFailure(e.message));
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Pedido>> getPedidoById(int id) async {
    try {
      final pedido = await remoteDataSource.getPedidoById(id);
      return Right(pedido);
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on ConnectionException catch (e) {
      return Left(ConnectionFailure(e.message));
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Pedido>> createPedido(Pedido pedido) async {
    try {
      final pedidoModel = PedidoModel.fromEntity(pedido);
      final createdPedido = await remoteDataSource.createPedido(pedidoModel);
      return Right(createdPedido);
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

  @override
  Future<Either<Failure, Pedido>> updatePedido(int id, Pedido pedido) async {
    try {
      final pedidoModel = PedidoModel.fromEntity(pedido);
      final updatedPedido = await remoteDataSource.updatePedido(id, pedidoModel);
      return Right(updatedPedido);
    } on ValidationException catch (e) {
      return Left(ValidationFailure(message: e.message, errors: e.errors));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on ConnectionException catch (e) {
      return Left(ConnectionFailure(e.message));
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deletePedido(int id) async {
    try {
      await remoteDataSource.deletePedido(id);
      return const Right(null);
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on ConnectionException catch (e) {
      return Left(ConnectionFailure(e.message));
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
}
