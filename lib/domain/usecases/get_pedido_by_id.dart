import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/pedido.dart';
import '../repositories/pedido_repository.dart';

class GetPedidoById {
  final PedidoRepository repository;

  GetPedidoById(this.repository);

  Future<Either<Failure, Pedido>> call(int id) async {
    return await repository.getPedidoById(id);
  }
}
