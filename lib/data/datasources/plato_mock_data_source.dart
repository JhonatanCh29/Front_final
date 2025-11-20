import '../models/plato_model.dart';
import 'mock_data_source.dart';

class PlatoMockDataSource {
  Future<List<PlatoModel>> getPlatos() async {
    // Simula delay de red
    await Future.delayed(const Duration(milliseconds: 400));
    return MockDataSource.getPlatos();
  }

  Future<PlatoModel?> getPlatoById(int id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final platos = MockDataSource.getPlatos();
    try {
      return platos.firstWhere((plato) => plato.id == id);
    } catch (e) {
      return null;
    }
  }
}