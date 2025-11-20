import '../../domain/entities/plato.dart';

class PlatoModel extends Plato {
  const PlatoModel({
    super.id,
    required super.nombre,
    super.descripcion,
    required super.precio,
  });

  factory PlatoModel.fromJson(Map<String, dynamic> json) {
    return PlatoModel(
      id: json['idPlato'] as int?,  // Backend usa 'idPlato'
      nombre: json['nombre']?.toString() ?? '',
      descripcion: json['descripcion']?.toString(),
      precio: (json['precio'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'descripcion': descripcion,
      'precio': precio,
    };
  }

  factory PlatoModel.fromEntity(Plato plato) {
    return PlatoModel(
      id: plato.id,
      nombre: plato.nombre,
      descripcion: plato.descripcion,
      precio: plato.precio,
    );
  }
}
