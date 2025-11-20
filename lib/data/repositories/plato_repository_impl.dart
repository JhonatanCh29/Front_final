import 'package:dartz/dartz.dart';
import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/plato.dart';
import '../../domain/repositories/plato_repository.dart';
import '../datasources/plato_remote_data_source.dart';
import '../models/plato_model.dart';

class PlatoRepositoryImpl implements PlatoRepository {
  final PlatoRemoteDataSource remoteDataSource;

  PlatoRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Plato>>> getPlatos() async {
    try {
      final platos = await remoteDataSource.getPlatos();
      return Right(platos);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on ConnectionException catch (e) {
      return Left(ConnectionFailure(e.message));
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Plato>> createPlato(Plato plato) async {
    try {
      final platoModel = PlatoModel.fromEntity(plato);
      final createdPlato = await remoteDataSource.createPlato(platoModel);
      return Right(createdPlato);
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
