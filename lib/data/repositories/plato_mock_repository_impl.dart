import 'package:dartz/dartz.dart';
import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/plato.dart';
import '../../domain/repositories/plato_repository.dart';
import '../datasources/plato_mock_data_source.dart';
import '../models/plato_model.dart';

class PlatoMockRepositoryImpl implements PlatoRepository {
  final PlatoMockDataSource mockDataSource;

  PlatoMockRepositoryImpl({required this.mockDataSource});

  @override
  Future<Either<Failure, List<Plato>>> getPlatos() async {
    try {
      final platos = await mockDataSource.getPlatos();
      return Right(platos);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on ConnectionException catch (e) {
      return Left(ConnectionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Error inesperado: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Plato>> createPlato(Plato plato) async {
    try {
      // Para el mock, simplemente devolvemos el plato con un ID generado
      final platoModel = PlatoModel(
        id: DateTime.now().millisecondsSinceEpoch,
        nombre: plato.nombre,
        descripcion: plato.descripcion,
        precio: plato.precio,
      );
      return Right(platoModel);
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
}