import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/plato.dart';
import '../repositories/plato_repository.dart';

class GetPlatos {
  final PlatoRepository repository;

  GetPlatos(this.repository);

  Future<Either<Failure, List<Plato>>> call() async {
    return await repository.getPlatos();
  }
}
