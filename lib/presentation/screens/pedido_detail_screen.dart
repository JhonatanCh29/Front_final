import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/utils/date_formatter.dart';
import '../providers/pedido_providers.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart';

class PedidoDetailScreen extends ConsumerWidget {
  final int pedidoId;

  const PedidoDetailScreen({super.key, required this.pedidoId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pedidoAsync = ref.watch(pedidoByIdProvider(pedidoId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del Pedido'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              context.push('/pedidos/edit/$pedidoId');
            },
          ),
        ],
      ),
      body: pedidoAsync.when(
        data: (pedido) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header con estado
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: _getEstadoColor(pedido.estado),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        _getEstadoIcon(pedido.estado),
                        size: 64,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        pedido.estado,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      if (pedido.fechaPedido != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          DateFormatter.formatDateTime(pedido.fechaPedido!),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Información del pedido
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoCard(
                        'Información General',
                        [
                          _buildInfoRow('Pedido #', '${pedido.id}'),
                          _buildInfoRow('Mesa', '${pedido.numeroMesa}'),
                        ],
                      ),
                      const SizedBox(height: 16),
                      
                      _buildInfoCard(
                        'Cliente',
                        [
                          _buildInfoRow('Nombre', pedido.clienteNombre ?? 'N/A'),
                          _buildInfoRow('Teléfono', pedido.clienteTelefono ?? 'N/A'),
                        ],
                      ),
                      const SizedBox(height: 16),
                      
                      _buildInfoCard(
                        'Plato',
                        [
                          _buildInfoRow('Nombre', pedido.platoNombre ?? 'N/A'),
                          if (pedido.platoDescripcion != null)
                            _buildInfoRow('Descripción', pedido.platoDescripcion!),
                          if (pedido.platoPrecio != null)
                            _buildInfoRow(
                              'Precio',
                              '${pedido.platoPrecio!.toStringAsFixed(2)} €',
                              isPrice: true,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const LoadingWidget(),
        error: (error, stack) => ErrorDisplayWidget(
          message: error.toString(),
          onRetry: () => ref.invalidate(pedidoByIdProvider(pedidoId)),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isPrice = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isPrice ? 20 : 16,
              fontWeight: isPrice ? FontWeight.bold : FontWeight.normal,
              color: isPrice ? Colors.green : null,
            ),
          ),
        ],
      ),
    );
  }

  Color _getEstadoColor(String estado) {
    switch (estado.toUpperCase()) {
      case 'PENDIENTE':
        return Colors.orange;
      case 'EN_PROCESO':
        return Colors.blue;
      case 'COMPLETADO':
        return Colors.green;
      case 'CANCELADO':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getEstadoIcon(String estado) {
    switch (estado.toUpperCase()) {
      case 'PENDIENTE':
        return Icons.schedule;
      case 'EN_PROCESO':
        return Icons.hourglass_empty;
      case 'COMPLETADO':
        return Icons.check_circle;
      case 'CANCELADO':
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }
}
