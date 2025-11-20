import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/pedido.dart';
import '../repositories/pedido_repository.dart';

class GetPedidos {
  final PedidoRepository repository;

  GetPedidos(this.repository);

  Future<Either<Failure, List<Pedido>>> call() async {
    return await repository.getPedidos();
  }
}
