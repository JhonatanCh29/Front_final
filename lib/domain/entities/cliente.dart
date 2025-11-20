import 'package:equatable/equatable.dart';

class Cliente extends Equatable {
  final int? id;
  final String nombre;
  final String telefono;

  const Cliente({
    this.id,
    required this.nombre,
    required this.telefono,
  });

  @override
  List<Object?> get props => [id, nombre, telefono];
}
