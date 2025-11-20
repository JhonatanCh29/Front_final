import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/screens/pedidos_list_screen.dart';
import '../../presentation/screens/pedido_detail_screen.dart';
import '../../presentation/screens/pedido_form_screen.dart';

final router = GoRouter(
  initialLocation: '/pedidos',
  routes: [
    GoRoute(
      path: '/pedidos',
      name: 'pedidos',
      builder: (context, state) => const PedidosListScreen(),
    ),
    GoRoute(
      path: '/pedidos/new',
      name: 'pedido-new',
      builder: (context, state) => const PedidoFormScreen(),
    ),
    GoRoute(
      path: '/pedidos/:id',
      name: 'pedido-detail',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return PedidoDetailScreen(pedidoId: id);
      },
    ),
    GoRoute(
      path: '/pedidos/edit/:id',
      name: 'pedido-edit',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return PedidoFormScreen(pedidoId: id);
      },
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('Error')),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 80, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            'Página no encontrada',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(state.uri.toString()),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () => context.go('/pedidos'),
            child: const Text('Ir a inicio'),
          ),
        ],
      ),
    ),
  ),
);
