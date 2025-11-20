import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../../core/errors/exceptions.dart';
import '../models/cliente_model.dart';

abstract class ClienteRemoteDataSource {
  Future<List<ClienteModel>> getClientes();
  Future<ClienteModel> createCliente(ClienteModel cliente);
}

class ClienteRemoteDataSourceImpl implements ClienteRemoteDataSource {
  final Dio dio;

  ClienteRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<ClienteModel>> getClientes() async {
    try {
      final response = await dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.clientesEndpoint}',
      );

      if (response.statusCode == 200) {
        final List<dynamic> clientesJson = response.data as List<dynamic>;
        return clientesJson
            .map((json) => ClienteModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerException('Error al obtener clientes');
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
  Future<ClienteModel> createCliente(ClienteModel cliente) async {
    try {
      final response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.clientesEndpoint}',
        data: cliente.toJson(),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return ClienteModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw ServerException('Error al crear cliente');
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
