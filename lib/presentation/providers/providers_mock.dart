import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/pedido_mock_data_source.dart';
import '../../data/datasources/cliente_mock_data_source.dart';
import '../../data/datasources/plato_mock_data_source.dart';
import '../../data/repositories/pedido_mock_repository_impl.dart';
import '../../data/repositories/cliente_mock_repository_impl.dart';
import '../../data/repositories/plato_mock_repository_impl.dart';
import '../../domain/repositories/pedido_repository.dart';
import '../../domain/repositories/cliente_repository.dart';
import '../../domain/repositories/plato_repository.dart';
import '../../domain/usecases/get_pedidos.dart';
import '../../domain/usecases/get_pedido_by_id.dart';
import '../../domain/usecases/create_pedido.dart';
import '../../domain/usecases/update_pedido.dart';
import '../../domain/usecases/delete_pedido.dart';
import '../../domain/usecases/get_clientes.dart';
import '../../domain/usecases/get_platos.dart';

// Mock Data Sources
final pedidoMockDataSourceProvider = Provider<PedidoMockDataSource>((ref) {
  return PedidoMockDataSource();
});

final clienteMockDataSourceProvider = Provider<ClienteMockDataSource>((ref) {
  return ClienteMockDataSource();
});

final platoMockDataSourceProvider = Provider<PlatoMockDataSource>((ref) {
  return PlatoMockDataSource();
});

// Mock Repositories
final pedidoMockRepositoryProvider = Provider<PedidoRepository>((ref) {
  return PedidoMockRepositoryImpl(
    mockDataSource: ref.watch(pedidoMockDataSourceProvider),
  );
});

final clienteMockRepositoryProvider = Provider<ClienteRepository>((ref) {
  return ClienteMockRepositoryImpl(
    mockDataSource: ref.watch(clienteMockDataSourceProvider),
  );
});

final platoMockRepositoryProvider = Provider<PlatoRepository>((ref) {
  return PlatoMockRepositoryImpl(
    mockDataSource: ref.watch(platoMockDataSourceProvider),
  );
});

// Use Cases - Mock versions
final getMockPedidosProvider = Provider<GetPedidos>((ref) {
  return GetPedidos(ref.watch(pedidoMockRepositoryProvider));
});

final getMockPedidoByIdProvider = Provider<GetPedidoById>((ref) {
  return GetPedidoById(ref.watch(pedidoMockRepositoryProvider));
});

final createMockPedidoProvider = Provider<CreatePedido>((ref) {
  return CreatePedido(ref.watch(pedidoMockRepositoryProvider));
});

final updateMockPedidoProvider = Provider<UpdatePedido>((ref) {
  return UpdatePedido(ref.watch(pedidoMockRepositoryProvider));
});

final deleteMockPedidoProvider = Provider<DeletePedido>((ref) {
  return DeletePedido(ref.watch(pedidoMockRepositoryProvider));
});

final getMockClientesProvider = Provider<GetClientes>((ref) {
  return GetClientes(ref.watch(clienteMockRepositoryProvider));
});

final getMockPlatosProvider = Provider<GetPlatos>((ref) {
  return GetPlatos(ref.watch(platoMockRepositoryProvider));
});