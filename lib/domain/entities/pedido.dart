import 'package:equatable/equatable.dart';

class Pedido extends Equatable {
  final int? id;
  final int numeroMesa;
  final String estado;  // Opcional con valor por defecto, el backend no lo maneja
  final DateTime? fechaPedido; // Opcional, el backend no lo maneja
  final int clienteId;
  final String? clienteNombre;
  final String? clienteTelefono;
  final int platoId;
  final String? platoNombre;
  final String? platoDescripcion;
  final double? platoPrecio;

  const Pedido({
    this.id,
    required this.numeroMesa,
    this.estado = 'PENDIENTE', // Valor por defecto ya que el backend no lo maneja
    this.fechaPedido,
    required this.clienteId,
    this.clienteNombre,
    this.clienteTelefono,
    required this.platoId,
    this.platoNombre,
    this.platoDescripcion,
    this.platoPrecio,
  });

  @override
  List<Object?> get props => [
        id,
        numeroMesa,
        estado,
        fechaPedido,
        clienteId,
        clienteNombre,
        clienteTelefono,
        platoId,
        platoNombre,
        platoDescripcion,
        platoPrecio,
      ];
}
