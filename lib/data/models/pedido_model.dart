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
    return PedidoModel(
      id: json['id'] as int?,
      numeroMesa: json['numeroMesa'] as int,
      estado: json['estado'] as String? ?? 'PENDIENTE',
      fechaPedido: json['fechaPedido'] != null
          ? DateTime.parse(json['fechaPedido'].toString())
          : null,
      clienteId: json['clienteId'] as int,
      clienteNombre: json['clienteNombre']?.toString(),
      clienteTelefono: json['clienteTelefono']?.toString(),
      platoId: json['platoId'] as int,
      platoNombre: json['platoNombre']?.toString(),
      platoDescripcion: json['platoDescripcion']?.toString(),
      platoPrecio: json['platoPrecio'] != null
          ? (json['platoPrecio'] as num).toDouble()
          : null,
    );
  }

  // ToJson para PedidoDTO (POST/PUT)
  Map<String, dynamic> toJson() {
    return {
      'numeroMesa': numeroMesa,
      'clienteId': clienteId,
      'platoId': platoId,
      'estado': estado,
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
