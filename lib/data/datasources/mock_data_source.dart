import '../models/pedido_model.dart';
import '../models/cliente_model.dart';
import '../models/plato_model.dart';

class MockDataSource {
  // Datos mock de clientes
  static List<ClienteModel> getClientes() {
    return [
      const ClienteModel(
        id: 1,
        nombre: 'Juan Pérez',
        telefono: '123456789',
      ),
      const ClienteModel(
        id: 2,
        nombre: 'María García',
        telefono: '987654321',
      ),
      const ClienteModel(
        id: 3,
        nombre: 'Carlos López',
        telefono: '456789123',
      ),
      const ClienteModel(
        id: 4,
        nombre: 'Ana Martínez',
        telefono: '789123456',
      ),
    ];
  }

  // Datos mock de platos
  static List<PlatoModel> getPlatos() {
    return [
      const PlatoModel(
        id: 1,
        nombre: 'Paella Valenciana',
        descripcion: 'Arroz con pollo, judías y pimiento',
        precio: 18.50,
      ),
      const PlatoModel(
        id: 2,
        nombre: 'Gazpacho Andaluz',
        descripcion: 'Sopa fría de tomate y verduras',
        precio: 8.00,
      ),
      const PlatoModel(
        id: 3,
        nombre: 'Tortilla Española',
        descripcion: 'Tortilla de patatas con cebolla',
        precio: 12.00,
      ),
      const PlatoModel(
        id: 4,
        nombre: 'Jamón Ibérico',
        descripcion: 'Jamón ibérico de bellota',
        precio: 22.00,
      ),
      const PlatoModel(
        id: 5,
        nombre: 'Pulpo a la Gallega',
        descripcion: 'Pulpo cocido con pimentón y aceite',
        precio: 16.50,
      ),
    ];
  }

  // Datos mock de pedidos
  static List<PedidoModel> getPedidos() {
    return [
      PedidoModel(
        id: 1,
        numeroMesa: 1,
        estado: 'PENDIENTE',
        fechaPedido: DateTime.now().subtract(const Duration(minutes: 10)),
        clienteId: 1,
        clienteNombre: 'Juan Pérez',
        clienteTelefono: '123456789',
        platoId: 1,
        platoNombre: 'Paella Valenciana',
        platoDescripcion: 'Arroz con pollo, judías y pimiento',
        platoPrecio: 18.50,
      ),
      PedidoModel(
        id: 2,
        numeroMesa: 3,
        estado: 'EN_PROCESO',
        fechaPedido: DateTime.now().subtract(const Duration(minutes: 25)),
        clienteId: 2,
        clienteNombre: 'María García',
        clienteTelefono: '987654321',
        platoId: 2,
        platoNombre: 'Gazpacho Andaluz',
        platoDescripcion: 'Sopa fría de tomate y verduras',
        platoPrecio: 8.00,
      ),
      PedidoModel(
        id: 3,
        numeroMesa: 5,
        estado: 'COMPLETADO',
        fechaPedido: DateTime.now().subtract(const Duration(hours: 1)),
        clienteId: 3,
        clienteNombre: 'Carlos López',
        clienteTelefono: '456789123',
        platoId: 3,
        platoNombre: 'Tortilla Española',
        platoDescripcion: 'Tortilla de patatas con cebolla',
        platoPrecio: 12.00,
      ),
    ];
  }
}