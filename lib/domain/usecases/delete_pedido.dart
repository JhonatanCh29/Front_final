import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../repositories/pedido_repository.dart';

class DeletePedido {
  final PedidoRepository repository;

  DeletePedido(this.repository);

  Future<Either<Failure, void>> call(int id) async {
    return await repository.deletePedido(id);
  }
}
