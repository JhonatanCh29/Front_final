import '../models/cliente_model.dart';
import 'mock_data_source.dart';

class ClienteMockDataSource {
  Future<List<ClienteModel>> getClientes() async {
    // Simula delay de red
    await Future.delayed(const Duration(milliseconds: 350));
    return MockDataSource.getClientes();
  }

  Future<ClienteModel> createCliente(ClienteModel cliente) async {
    await Future.delayed(const Duration(milliseconds: 600));
    
    final nuevoCliente = ClienteModel(
      id: DateTime.now().millisecondsSinceEpoch,
      nombre: cliente.nombre,
      telefono: cliente.telefono,
    );
    
    return nuevoCliente;
  }
}