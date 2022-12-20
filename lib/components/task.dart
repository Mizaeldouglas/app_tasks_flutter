import 'package:alura_flutter_curso_1/components/difficulty.dart';
import 'package:alura_flutter_curso_1/data/task_dao.dart';
import 'package:flutter/material.dart';

class Tasks extends StatefulWidget {
  final String nome;
  final String foto;
  final int dificuldade;
  Tasks(this.nome, this.foto, {Key? key, required this.dificuldade})
      : super(key: key);
  int nivel = 0;

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  bool assetOrNetwork() {
    if (widget.foto.contains('http')) {
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.blue,
            ),
            height: 140,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.black26,
                      ),
                      width: 72,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: assetOrNetwork()
                            ? Image.asset(
                                widget.foto,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                widget.foto,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(
                            widget.nome,
                            style: const TextStyle(
                                fontSize: 24, overflow: TextOverflow.ellipsis),
                          ),
                        ),
                        Row(
                          children: [
                            Dificulty(dificuldade: widget.dificuldade)
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        height: 52,
                        width: 52,
                        child: ElevatedButton(
                          onLongPress: () {
                            TaskDao().delete(widget.nome);
                          },
                          onPressed: () {
                            setState(() {
                              widget.nivel++;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Icon(Icons.arrow_drop_up),
                              Text(
                                'UP',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                    ),
                    child: SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                        color: Colors.white,
                        value: (widget.dificuldade > 0)
                            ? (widget.nivel / widget.dificuldade) / 10
                            : 1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Nivel: ${widget.nivel}',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                    child: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Row(
                                children: const [
                                  Center(child: Text("Deletar")),
                                ],
                              ),
                              content: const Text(
                                  "Tem certeza que deseja DELETAR essa Tarefa"),
                              actions: [
                                TextButton(
                                  onPressed: () async {
                                    await TaskDao().delete(widget.nome);
                                    // ignore: use_build_context_synchronously
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text(
                                            "Tarefa DELETADA, dar Reload no botão de reload"),
                                      ),
                                    );
                                  },
                                  child: const Text("SIM"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("NÃO"),
                                ),
                              ],
                            );
                          });
                    },
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
