import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/pedido.dart';
import '../providers/pedido_providers.dart';
import '../widgets/loading_widget.dart';

class PedidoFormScreen extends ConsumerStatefulWidget {
  final int? pedidoId;

  const PedidoFormScreen({super.key, this.pedidoId});

  @override
  ConsumerState<PedidoFormScreen> createState() => _PedidoFormScreenState();
}

class _PedidoFormScreenState extends ConsumerState<PedidoFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _numeroMesaController = TextEditingController();

  int? _selectedClienteId;
  int? _selectedPlatoId;
  String _selectedEstado = 'PENDIENTE';

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.pedidoId != null) {
      // Cargar datos del pedido para editar
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _loadPedidoData();
      });
    }
  }

  Future<void> _loadPedidoData() async {
    if (widget.pedidoId == null) return;

    final pedidoAsync = ref.read(pedidoByIdProvider(widget.pedidoId!));

    pedidoAsync.whenData((pedido) {
      setState(() {
        _numeroMesaController.text = pedido.numeroMesa.toString();
        _selectedClienteId = pedido.clienteId;
        _selectedPlatoId = pedido.platoId;
        _selectedEstado = pedido.estado;
      });
    });
  }

  @override
  void dispose() {
    _numeroMesaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final clientesAsync = ref.watch(clientesProvider);
    final platosAsync = ref.watch(platosProvider);
    final formState = ref.watch(pedidoFormProvider);

    // Escuchar cambios en el estado del formulario
    ref.listen<PedidoFormState>(pedidoFormProvider, (previous, next) {
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error!), backgroundColor: Colors.red),
        );
      } else if (next.savedPedido != null && !next.isLoading) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.pedidoId == null
                  ? 'Pedido creado exitosamente'
                  : 'Pedido actualizado exitosamente',
            ),
            backgroundColor: Colors.green,
          ),
        );
        context.pop();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pedidoId == null ? 'Nuevo Pedido' : 'Editar Pedido'),
      ),
      body: clientesAsync.when(
        data: (clientes) => platosAsync.when(
          data: (platos) {
            if (_isLoading || formState.isLoading) {
              return const LoadingWidget();
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Número de mesa
                    TextFormField(
                      controller: _numeroMesaController,
                      decoration: const InputDecoration(
                        labelText: 'Número de Mesa',
                        prefixIcon: Icon(Icons.table_restaurant),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'El número de mesa es obligatorio';
                        }
                        final numero = int.tryParse(value);
                        if (numero == null || numero <= 0) {
                          return 'Ingrese un número de mesa válido';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Cliente
                    DropdownButtonFormField<int>(
                      value: _selectedClienteId,
                      decoration: const InputDecoration(
                        labelText: 'Cliente',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                      items: clientes.map((cliente) {
                        return DropdownMenuItem<int>(
                          value: cliente.id,
                          child: Text(
                            '${cliente.nombre} - ${cliente.telefono}',
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedClienteId = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Seleccione un cliente';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Plato
                    DropdownButtonFormField<int>(
                      value: _selectedPlatoId,
                      decoration: const InputDecoration(
                        labelText: 'Plato',
                        prefixIcon: Icon(Icons.restaurant),
                        border: OutlineInputBorder(),
                      ),
                      items: platos.map((plato) {
                        return DropdownMenuItem<int>(
                          value: plato.id,
                          child: Text(
                            '${plato.nombre} - ${plato.precio.toStringAsFixed(2)} €',
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedPlatoId = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Seleccione un plato';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Estado
                    DropdownButtonFormField<String>(
                      value: _selectedEstado,
                      decoration: const InputDecoration(
                        labelText: 'Estado',
                        prefixIcon: Icon(Icons.info),
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'PENDIENTE',
                          child: Text('Pendiente'),
                        ),
                        DropdownMenuItem(
                          value: 'EN_PROCESO',
                          child: Text('En Proceso'),
                        ),
                        DropdownMenuItem(
                          value: 'COMPLETADO',
                          child: Text('Completado'),
                        ),
                        DropdownMenuItem(
                          value: 'CANCELADO',
                          child: Text('Cancelado'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedEstado = value;
                          });
                        }
                      },
                    ),

                    const SizedBox(height: 32),

                    // Botones
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => context.pop(),
                            child: const Text('Cancelar'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: FilledButton(
                            onPressed: _submitForm,
                            child: Text(
                              widget.pedidoId == null ? 'Crear' : 'Actualizar',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
          loading: () => const LoadingWidget(),
          error: (error, stack) =>
              Center(child: Text('Error al cargar platos: $error')),
        ),
        loading: () => const LoadingWidget(),
        error: (error, stack) =>
            Center(child: Text('Error al cargar clientes: $error')),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final pedido = Pedido(
      id: widget.pedidoId,
      numeroMesa: int.parse(_numeroMesaController.text),
      clienteId: _selectedClienteId!,
      platoId: _selectedPlatoId!,
      estado: _selectedEstado,
    );

    if (widget.pedidoId == null) {
      await ref.read(pedidoFormProvider.notifier).createPedido(pedido);
    } else {
      await ref
          .read(pedidoFormProvider.notifier)
          .updatePedido(widget.pedidoId!, pedido);
    }
  }
}
