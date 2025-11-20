import '../models/pedido_model.dart';
import 'mock_data_source.dart';

class PedidoMockDataSource {
  static List<PedidoModel> _pedidos = MockDataSource.getPedidos();
  static int _nextId = 4;

  Future<List<PedidoModel>> getPedidos() async {
    // Simula delay de red
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_pedidos);
  }

  Future<PedidoModel> getPedidoById(int id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final pedido = _pedidos.firstWhere(
      (p) => p.id == id,
      orElse: () => throw Exception('Pedido no encontrado'),
    );
    return pedido;
  }

  Future<PedidoModel> createPedido(PedidoModel pedido) async {
    await Future.delayed(const Duration(milliseconds: 800));
    
    // Buscar datos del cliente y plato
    final clientes = MockDataSource.getClientes();
    final platos = MockDataSource.getPlatos();
    
    final cliente = clientes.firstWhere((c) => c.id == pedido.clienteId);
    final plato = platos.firstWhere((p) => p.id == pedido.platoId);
    
    final nuevoPedido = PedidoModel(
      id: _nextId++,
      numeroMesa: pedido.numeroMesa,
      estado: pedido.estado,
      fechaPedido: DateTime.now(),
      clienteId: pedido.clienteId,
      clienteNombre: cliente.nombre,
      clienteTelefono: cliente.telefono,
      platoId: pedido.platoId,
      platoNombre: plato.nombre,
      platoDescripcion: plato.descripcion,
      platoPrecio: plato.precio,
    );
    
    _pedidos.add(nuevoPedido);
    return nuevoPedido;
  }

  Future<PedidoModel> updatePedido(int id, PedidoModel pedido) async {
    await Future.delayed(const Duration(milliseconds: 600));
    
    final index = _pedidos.indexWhere((p) => p.id == id);
    if (index == -1) {
      throw Exception('Pedido no encontrado');
    }
    
    // Buscar datos del cliente y plato
    final clientes = MockDataSource.getClientes();
    final platos = MockDataSource.getPlatos();
    
    final cliente = clientes.firstWhere((c) => c.id == pedido.clienteId);
    final plato = platos.firstWhere((p) => p.id == pedido.platoId);
    
    final pedidoActualizado = PedidoModel(
      id: id,
      numeroMesa: pedido.numeroMesa,
      estado: pedido.estado,
      fechaPedido: _pedidos[index].fechaPedido,
      clienteId: pedido.clienteId,
      clienteNombre: cliente.nombre,
      clienteTelefono: cliente.telefono,
      platoId: pedido.platoId,
      platoNombre: plato.nombre,
      platoDescripcion: plato.descripcion,
      platoPrecio: plato.precio,
    );
    
    _pedidos[index] = pedidoActualizado;
    return pedidoActualizado;
  }

  Future<void> deletePedido(int id) async {
    await Future.delayed(const Duration(milliseconds: 400));
    
    final index = _pedidos.indexWhere((p) => p.id == id);
    if (index == -1) {
      throw Exception('Pedido no encontrado');
    }
    
    _pedidos.removeAt(index);
  }
}