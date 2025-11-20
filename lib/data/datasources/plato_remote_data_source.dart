import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../../core/errors/exceptions.dart';
import '../models/plato_model.dart';

abstract class PlatoRemoteDataSource {
  Future<List<PlatoModel>> getPlatos();
  Future<PlatoModel> createPlato(PlatoModel plato);
}

class PlatoRemoteDataSourceImpl implements PlatoRemoteDataSource {
  final Dio dio;

  PlatoRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<PlatoModel>> getPlatos() async {
    try {
      final response = await dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.platosEndpoint}',
      );

      if (response.statusCode == 200) {
        final List<dynamic> platosJson = response.data as List<dynamic>;
        return platosJson
            .map((json) => PlatoModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerException('Error al obtener platos');
      }
    } on DioException catch (e) {
      if (e.response == null) {
        throw ConnectionException();
      } else {
        throw ServerException();
      }
    }
  }

  @override
  Future<PlatoModel> createPlato(PlatoModel plato) async {
    try {
      final response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.platosEndpoint}',
        data: plato.toJson(),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return PlatoModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw ServerException('Error al crear plato');
      }
    } on DioException catch (e) {
      if (e.response == null) {
        throw ConnectionException();
      } else if (e.response!.statusCode == 400) {
        throw ValidationException();
      } else {
        throw ServerException();
      }
    }
  }
}
