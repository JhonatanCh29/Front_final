import 'package:dartz/dartz.dart';
import '../entities/plato.dart';
import '../../core/errors/failures.dart';

abstract class PlatoRepository {
  Future<Either<Failure, List<Plato>>> getPlatos();
  Future<Either<Failure, Plato>> createPlato(Plato plato);
}
