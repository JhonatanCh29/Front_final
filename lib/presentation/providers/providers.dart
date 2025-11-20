import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/api_constants.dart';
import '../../data/datasources/pedido_remote_data_source.dart';
import '../../data/datasources/cliente_remote_data_source.dart';
import '../../data/datasources/plato_remote_data_source.dart';
import '../../data/repositories/pedido_repository_impl.dart';
import '../../data/repositories/cliente_repository_impl.dart';
import '../../data/repositories/plato_repository_impl.dart';
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

// Dio Provider
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      headers: ApiConstants.headers,
      connectTimeout: const Duration(milliseconds: ApiConstants.connectionTimeout),
      receiveTimeout: const Duration(milliseconds: ApiConstants.receiveTimeout),
    ),
  );
  
  // Interceptor para logging (opcional)
  dio.interceptors.add(
    LogInterceptor(
      requestBody: true,
      responseBody: true,
      error: true,
    ),
  );
  
  return dio;
});

// Data Sources
final pedidoRemoteDataSourceProvider = Provider<PedidoRemoteDataSource>((ref) {
  return PedidoRemoteDataSourceImpl(dio: ref.watch(dioProvider));
});

final clienteRemoteDataSourceProvider = Provider<ClienteRemoteDataSource>((ref) {
  return ClienteRemoteDataSourceImpl(dio: ref.watch(dioProvider));
});

final platoRemoteDataSourceProvider = Provider<PlatoRemoteDataSource>((ref) {
  return PlatoRemoteDataSourceImpl(dio: ref.watch(dioProvider));
});

// Repositories
final pedidoRepositoryProvider = Provider<PedidoRepository>((ref) {
  return PedidoRepositoryImpl(
    remoteDataSource: ref.watch(pedidoRemoteDataSourceProvider),
  );
});

final clienteRepositoryProvider = Provider<ClienteRepository>((ref) {
  return ClienteRepositoryImpl(
    remoteDataSource: ref.watch(clienteRemoteDataSourceProvider),
  );
});

final platoRepositoryProvider = Provider<PlatoRepository>((ref) {
  return PlatoRepositoryImpl(
    remoteDataSource: ref.watch(platoRemoteDataSourceProvider),
  );
});

// Use Cases - Pedidos
final getPedidosProvider = Provider<GetPedidos>((ref) {
  return GetPedidos(ref.watch(pedidoRepositoryProvider));
});

final getPedidoByIdProvider = Provider<GetPedidoById>((ref) {
  return GetPedidoById(ref.watch(pedidoRepositoryProvider));
});

final createPedidoProvider = Provider<CreatePedido>((ref) {
  return CreatePedido(ref.watch(pedidoRepositoryProvider));
});

final updatePedidoProvider = Provider<UpdatePedido>((ref) {
  return UpdatePedido(ref.watch(pedidoRepositoryProvider));
});

final deletePedidoProvider = Provider<DeletePedido>((ref) {
  return DeletePedido(ref.watch(pedidoRepositoryProvider));
});

// Use Cases - Clientes y Platos
final getClientesProvider = Provider<GetClientes>((ref) {
  return GetClientes(ref.watch(clienteRepositoryProvider));
});

final getPlatosProvider = Provider<GetPlatos>((ref) {
  return GetPlatos(ref.watch(platoRepositoryProvider));
});
