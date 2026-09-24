import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de tareas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const ListaVivaPage(title: 'Tareas Ander'),
    );
  }
}

class ListaVivaPage extends StatefulWidget {
  const ListaVivaPage({super.key, required this.title});

  final String title;

  @override
  State<ListaVivaPage> createState() => _ListaVivaPageState();
}

class _ListaVivaPageState extends State<ListaVivaPage> {
  final List<String> _nombres = ['Ander', 'Cesar', 'Erick', 'Juan'];
  final List<int> _puntos = [0, 0, 0, 0, 0];

  final List<String> _tareas = [
    'Subir captura de una madre',
    'Responder otra madre',
    'Subir captura de una madre',
    'Responder otra madre',
    'Subir captura de una madre',
    'Responder otra madre',
    'Subir captura de una madre',
    'Responder otra madre',
  ];
  final List<bool> _completada = [false, true, false, true, false, true, false, true];

  bool _mostrarSoloPendientes = false;

  void _eliminarElemento(int index) {
    setState(() {
      _tareas.removeAt(index);
      _completada.removeAt(index);
    });
  }

  void _marcarVista(int index, [bool? valor]) {
    setState(() {
      _completada[index] = !_completada[index];
    });
  }

  void _agregarElemento() {
    setState(() {
      _tareas.add('Tarea ${_tareas.length + 1}');
      _completada.add(false);
    });
  }

  void _sumar(int index) {
    setState(() {
      _puntos[index]++;
    });
  }

  void _restar(int index) {
    setState(() {
      if (_puntos[index] > 0) {
        _puntos[index]--;
      }
    });
  }

  void _agregar() {
    setState(() {
      _nombres.add('Integrante ${_nombres.length + 1}');
      _puntos.add(0);
    });
  }

  void _resetPuntos() {
    setState(() {
      for (var i = 0; i < _puntos.length; i++) {
        _puntos[i] = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final total = _puntos.fold<int>(0, (a, b) => a + b);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Completadas: ${_completada.where((element) => element).length} / ${_completada.length}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text('Filtrar: '),
                      Switch(
                        value: _mostrarSoloPendientes,
                        onChanged: (value) {
                          setState(() {
                            _mostrarSoloPendientes = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tareas.length,
              itemBuilder: (context, index) {
                if (_mostrarSoloPendientes && _completada[index]) {
                  return const SizedBox.shrink();
                }

                return Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: Checkbox(
                      value: _completada[index],
                      onChanged: (bool? newValue) {
                        _marcarVista(index, newValue);
                      },
                    ),
                    title: Text(
                      _tareas[index],
                      style: TextStyle(
                        decoration: _completada[index]
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: _completada[index]
                            ? Colors.grey
                            : Colors.black,
                      ),
                    ),
                    trailing: IconButton(
                      tooltip: 'Eliminar',
                      onPressed: () => _eliminarElemento(index),
                      icon: const Icon(Icons.delete),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _agregarElemento,
        icon: const Icon(Icons.add),
        label: const Text('Agregar tarea'),
      ),
    );
  }
}
