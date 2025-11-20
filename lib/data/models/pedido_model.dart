import '../../domain/entities/pedido.dart';

class PedidoModel extends Pedido {
  const PedidoModel({
    super.id,
    required super.numeroMesa,
    required super.estado,
    super.fechaPedido,
    required super.clienteId,
    super.clienteNombre,
    super.clienteTelefono,
    required super.platoId,
    super.platoNombre,
    super.platoDescripcion,
    super.platoPrecio,
  });

  // FromJson para PedidoResponseDTO (GET)
  factory PedidoModel.fromJson(Map<String, dynamic> json) {
    final cliente = json['cliente'] as Map<String, dynamic>?;
    final plato = json['plato'] as Map<String, dynamic>?;
    
    return PedidoModel(
      id: json['idPedido'] as int?,  // Backend usa 'idPedido'
      numeroMesa: json['numeroMesa'] as int,
      estado: 'PENDIENTE',  // Tu backend no maneja estado, usar default
      fechaPedido: DateTime.now(),  // Tu backend no maneja fecha, usar actual
      clienteId: cliente?['idCliente'] as int? ?? 0,
      clienteNombre: cliente?['nombre']?.toString(),
      clienteTelefono: cliente?['telefono']?.toString(),
      platoId: plato?['idPlato'] as int? ?? 0,
      platoNombre: plato?['nombre']?.toString(),
      platoDescripcion: plato?['descripcion']?.toString(),
      platoPrecio: plato?['precio'] != null
          ? (plato!['precio'] as num).toDouble()
          : null,
    );
  }

  // ToJson para PedidoDTO (POST/PUT) - Estructura que espera el backend
  Map<String, dynamic> toJson() {
    return {
      'numeroMesa': numeroMesa,
      'plato': {
        'idPlato': platoId
      },
      'cliente': {
        'idCliente': clienteId
      },
    };
  }

  // FromEntity
  factory PedidoModel.fromEntity(Pedido pedido) {
    return PedidoModel(
      id: pedido.id,
      numeroMesa: pedido.numeroMesa,
      estado: pedido.estado,
      fechaPedido: pedido.fechaPedido,
      clienteId: pedido.clienteId,
      clienteNombre: pedido.clienteNombre,
      clienteTelefono: pedido.clienteTelefono,
      platoId: pedido.platoId,
      platoNombre: pedido.platoNombre,
      platoDescripcion: pedido.platoDescripcion,
      platoPrecio: pedido.platoPrecio,
    );
  }
}
