import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/pedido.dart';
import '../repositories/pedido_repository.dart';

class CreatePedido {
  final PedidoRepository repository;

  CreatePedido(this.repository);

  Future<Either<Failure, Pedido>> call(Pedido pedido) async {
    return await repository.createPedido(pedido);
  }
}
