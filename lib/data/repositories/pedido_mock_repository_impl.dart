import 'package:dartz/dartz.dart';
import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/pedido.dart';
import '../../domain/repositories/pedido_repository.dart';
import '../datasources/pedido_mock_data_source.dart';
import '../models/pedido_model.dart';

class PedidoMockRepositoryImpl implements PedidoRepository {
  final PedidoMockDataSource mockDataSource;

  PedidoMockRepositoryImpl({required this.mockDataSource});

  @override
  Future<Either<Failure, List<Pedido>>> getPedidos() async {
    try {
      final pedidos = await mockDataSource.getPedidos();
      return Right(pedidos);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on ConnectionException catch (e) {
      return Left(ConnectionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Error inesperado: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Pedido>> getPedidoById(int id) async {
    try {
      final pedido = await mockDataSource.getPedidoById(id);
      return Right(pedido);
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on ConnectionException catch (e) {
      return Left(ConnectionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Error inesperado: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Pedido>> createPedido(Pedido pedido) async {
    try {
      final pedidoModel = PedidoModel.fromEntity(pedido);
      final createdPedido = await mockDataSource.createPedido(pedidoModel);
      return Right(createdPedido);
    } on ValidationException catch (e) {
      return Left(ValidationFailure(message: e.message, errors: e.errors));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on ConnectionException catch (e) {
      return Left(ConnectionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Error inesperado: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Pedido>> updatePedido(int id, Pedido pedido) async {
    try {
      final pedidoModel = PedidoModel.fromEntity(pedido);
      final updatedPedido = await mockDataSource.updatePedido(id, pedidoModel);
      return Right(updatedPedido);
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(message: e.message, errors: e.errors));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on ConnectionException catch (e) {
      return Left(ConnectionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Error inesperado: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deletePedido(int id) async {
    try {
      await mockDataSource.deletePedido(id);
      return const Right(null);
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on ConnectionException catch (e) {
      return Left(ConnectionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Error inesperado: ${e.toString()}'));
    }
  }
}