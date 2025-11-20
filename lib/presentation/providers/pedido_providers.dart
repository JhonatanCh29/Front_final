import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/pedido.dart';
import '../../domain/entities/cliente.dart';
import '../../domain/entities/plato.dart';
import 'providers.dart';

// Estado para lista de pedidos
final pedidosProvider = FutureProvider<List<Pedido>>((ref) async {
  final getPedidos = ref.watch(getPedidosProvider);
  final result = await getPedidos();
  
  return result.fold(
    (failure) => throw Exception(failure.message),
    (pedidos) => pedidos,
  );
});

// Estado para pedido individual
final pedidoByIdProvider = FutureProvider.family<Pedido, int>((ref, id) async {
  final getPedidoById = ref.watch(getPedidoByIdProvider);
  final result = await getPedidoById(id);
  
  return result.fold(
    (failure) => throw Exception(failure.message),
    (pedido) => pedido,
  );
});

// Estado para lista de clientes
final clientesProvider = FutureProvider<List<Cliente>>((ref) async {
  final getClientes = ref.watch(getClientesProvider);
  final result = await getClientes();
  
  return result.fold(
    (failure) => throw Exception(failure.message),
    (clientes) => clientes,
  );
});

// Estado para lista de platos
final platosProvider = FutureProvider<List<Plato>>((ref) async {
  final getPlatos = ref.watch(getPlatosProvider);
  final result = await getPlatos();
  
  return result.fold(
    (failure) => throw Exception(failure.message),
    (platos) => platos,
  );
});

// Estado para crear/editar pedido
class PedidoFormState {
  final bool isLoading;
  final String? error;
  final Pedido? savedPedido;

  PedidoFormState({
    this.isLoading = false,
    this.error,
    this.savedPedido,
  });

  PedidoFormState copyWith({
    bool? isLoading,
    String? error,
    Pedido? savedPedido,
  }) {
    return PedidoFormState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      savedPedido: savedPedido ?? this.savedPedido,
    );
  }
}

class PedidoFormNotifier extends StateNotifier<PedidoFormState> {
  final Ref ref;

  PedidoFormNotifier(this.ref) : super(PedidoFormState());

  Future<void> createPedido(Pedido pedido) async {
    state = state.copyWith(isLoading: true, error: null);
    
    final createPedido = ref.read(createPedidoProvider);
    final result = await createPedido(pedido);
    
    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
      },
      (savedPedido) {
        state = state.copyWith(isLoading: false, savedPedido: savedPedido);
        // Invalidar la lista para que se recargue
        ref.invalidate(pedidosProvider);
      },
    );
  }

  Future<void> updatePedido(int id, Pedido pedido) async {
    state = state.copyWith(isLoading: true, error: null);
    
    final updatePedido = ref.read(updatePedidoProvider);
    final result = await updatePedido(id, pedido);
    
    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
      },
      (savedPedido) {
        state = state.copyWith(isLoading: false, savedPedido: savedPedido);
        // Invalidar la lista para que se recargue
        ref.invalidate(pedidosProvider);
      },
    );
  }

  Future<void> deletePedido(int id) async {
    state = state.copyWith(isLoading: true, error: null);
    
    final deletePedido = ref.read(deletePedidoProvider);
    final result = await deletePedido(id);
    
    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
      },
      (_) {
        state = state.copyWith(isLoading: false);
        // Invalidar la lista para que se recargue
        ref.invalidate(pedidosProvider);
      },
    );
  }

  void resetState() {
    state = PedidoFormState();
  }
}

final pedidoFormProvider = StateNotifierProvider<PedidoFormNotifier, PedidoFormState>((ref) {
  return PedidoFormNotifier(ref);
});
