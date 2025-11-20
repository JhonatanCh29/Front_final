import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../../core/errors/exceptions.dart';
import '../models/pedido_model.dart';
import '../models/error_response_model.dart';

abstract class PedidoRemoteDataSource {
  Future<List<PedidoModel>> getPedidos();
  Future<PedidoModel> getPedidoById(int id);
  Future<PedidoModel> createPedido(PedidoModel pedido);
  Future<PedidoModel> updatePedido(int id, PedidoModel pedido);
  Future<void> deletePedido(int id);
}

class PedidoRemoteDataSourceImpl implements PedidoRemoteDataSource {
  final Dio dio;

  PedidoRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<PedidoModel>> getPedidos() async {
    try {
      final response = await dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.pedidosEndpoint}',
      );

      if (response.statusCode == 200) {
        final List<dynamic> pedidosJson = response.data as List<dynamic>;
        return pedidosJson
            .map((json) => PedidoModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerException('Error al obtener pedidos');
      }
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  @override
  Future<PedidoModel> getPedidoById(int id) async {
    try {
      final response = await dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.pedidosEndpoint}/$id',
      );

      if (response.statusCode == 200) {
        return PedidoModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw ServerException('Error al obtener pedido');
      }
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  @override
  Future<PedidoModel> createPedido(PedidoModel pedido) async {
    try {
      final response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.pedidosEndpoint}',
        data: pedido.toJson(),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return PedidoModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw ServerException('Error al crear pedido');
      }
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  @override
  Future<PedidoModel> updatePedido(int id, PedidoModel pedido) async {
    try {
      final response = await dio.put(
        '${ApiConstants.baseUrl}${ApiConstants.pedidosEndpoint}/$id',
        data: pedido.toJson(),
      );

      if (response.statusCode == 200) {
        return PedidoModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw ServerException('Error al actualizar pedido');
      }
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  @override
  Future<void> deletePedido(int id) async {
    try {
      final response = await dio.delete(
        '${ApiConstants.baseUrl}${ApiConstants.pedidosEndpoint}/$id',
      );

      if (response.statusCode != 204 && response.statusCode != 200) {
        throw ServerException('Error al eliminar pedido');
      }
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    }
  }

  void _handleDioError(DioException e) {
    if (e.response != null) {
      final statusCode = e.response!.statusCode;
      
      if (statusCode == 404) {
        final errorResponse = ErrorResponseModel.fromJson(
          e.response!.data as Map<String, dynamic>,
        );
        throw NotFoundException(errorResponse.message);
      } else if (statusCode == 400) {
        final errorResponse = ErrorResponseModel.fromJson(
          e.response!.data as Map<String, dynamic>,
        );
        throw ValidationException(
          message: errorResponse.message,
          errors: errorResponse.errors,
        );
      } else if (statusCode! >= 500) {
        final errorResponse = ErrorResponseModel.fromJson(
          e.response!.data as Map<String, dynamic>,
        );
        throw ServerException(errorResponse.message);
      }
    } else {
      // Error de conexión
      throw ConnectionException('No se pudo conectar con el servidor');
    }
  }
}
