import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/pedido.dart';
import '../repositories/pedido_repository.dart';

class UpdatePedido {
  final PedidoRepository repository;

  UpdatePedido(this.repository);

  Future<Either<Failure, Pedido>> call(int id, Pedido pedido) async {
    return await repository.updatePedido(id, pedido);
  }
}
