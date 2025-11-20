import 'package:equatable/equatable.dart';

class Plato extends Equatable {
  final int? id;
  final String nombre;
  final String? descripcion;
  final double precio;

  const Plato({
    this.id,
    required this.nombre,
    this.descripcion,
    required this.precio,
  });

  @override
  List<Object?> get props => [id, nombre, descripcion, precio];
}
