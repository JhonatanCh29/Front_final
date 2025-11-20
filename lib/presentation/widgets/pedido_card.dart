import 'package:flutter/material.dart';
import '../../domain/entities/pedido.dart';
import '../../core/utils/date_formatter.dart';

class PedidoCard extends StatelessWidget {
  final Pedido pedido;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const PedidoCard({
    super.key,
    required this.pedido,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Número de pedido y mesa
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pedido #${pedido.id}',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.table_restaurant, size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              'Mesa ${pedido.numeroMesa}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  // Estado
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _getEstadoColor(pedido.estado),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      pedido.estado,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              
              const Divider(height: 24),
              
              // Cliente
              Row(
                children: [
                  const Icon(Icons.person, size: 16, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      pedido.clienteNombre ?? 'Cliente desconocido',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 8),
              
              // Plato
              Row(
                children: [
                  const Icon(Icons.restaurant, size: 16, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      pedido.platoNombre ?? 'Plato desconocido',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  if (pedido.platoPrecio != null)
                    Text(
                      '${pedido.platoPrecio!.toStringAsFixed(2)} €',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                ],
              ),
              
              if (pedido.fechaPedido != null) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 16, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(
                      DateFormatter.formatDateTime(pedido.fechaPedido!),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
              
              // Botones de acción
              if (onEdit != null || onDelete != null) ...[
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (onEdit != null)
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: onEdit,
                        tooltip: 'Editar',
                      ),
                    if (onDelete != null)
                      IconButton(
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: onDelete,
                        tooltip: 'Eliminar',
                      ),
                  ],
                ),
              ],
            ],
          ),
        ),
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
}
