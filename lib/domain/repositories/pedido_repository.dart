import 'package:dartz/dartz.dart';
import '../entities/pedido.dart';
import '../../core/errors/failures.dart';

abstract class PedidoRepository {
  Future<Either<Failure, List<Pedido>>> getPedidos();
  Future<Either<Failure, Pedido>> getPedidoById(int id);
  Future<Either<Failure, Pedido>> createPedido(Pedido pedido);
  Future<Either<Failure, Pedido>> updatePedido(int id, Pedido pedido);
  Future<Either<Failure, void>> deletePedido(int id);
}
