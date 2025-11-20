import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/pedido_providers.dart';
import '../widgets/pedido_card.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart';

class PedidosListScreen extends ConsumerWidget {
  const PedidosListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pedidosAsync = ref.watch(pedidosProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(pedidosProvider),
          ),
        ],
      ),
      body: pedidosAsync.when(
        data: (pedidos) {
          if (pedidos.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.receipt_long, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No hay pedidos',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(pedidosProvider);
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: pedidos.length,
              itemBuilder: (context, index) {
                final pedido = pedidos[index];
                return PedidoCard(
                  pedido: pedido,
                  onTap: () {
                    context.push('/pedidos/${pedido.id}');
                  },
                  onDelete: () async {
                    final confirm = await _showDeleteDialog(context);
                    if (confirm == true && pedido.id != null) {
                      await ref
                          .read(pedidoFormProvider.notifier)
                          .deletePedido(pedido.id!);
                    }
                  },
                  onEdit: () {
                    context.push('/pedidos/edit/${pedido.id}');
                  },
                );
              },
            ),
          );
        },
        loading: () => const LoadingWidget(),
        error: (error, stack) => ErrorDisplayWidget(
          message: error.toString(),
          onRetry: () => ref.invalidate(pedidosProvider),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/pedidos/new'),
        icon: const Icon(Icons.add),
        label: const Text('Nuevo Pedido'),
      ),
    );
  }

  Future<bool?> _showDeleteDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Pedido'),
        content: const Text('¿Está seguro de que desea eliminar este pedido?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }
}
