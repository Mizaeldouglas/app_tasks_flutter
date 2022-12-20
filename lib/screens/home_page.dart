import 'package:alura_flutter_curso_1/components/task.dart';
import 'package:alura_flutter_curso_1/data/task_dao.dart';
import 'package:alura_flutter_curso_1/data/task_inherited.dart';
import 'package:alura_flutter_curso_1/screens/form_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool opacidade = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarefas'),
        leading: Container(),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 70),
        child: FutureBuilder<List<Tasks>>(
          future: TaskDao().findAll(),
          builder: ((context, snapshot) {
            List<Tasks>? items = snapshot.data;
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Center(
                  child: Column(
                    children: const [
                      CircularProgressIndicator(),
                      Text("Carregando...")
                    ],
                  ),
                );
              // break;
              case ConnectionState.waiting:
                Center(
                  child: Column(
                    children: const [
                      CircularProgressIndicator(),
                      Text("Carregando...")
                    ],
                  ),
                );
                break;
              case ConnectionState.active:
                Center(
                  child: Column(
                    children: const [
                      CircularProgressIndicator(),
                      Text("Carregando...")
                    ],
                  ),
                );
                break;
              case ConnectionState.done:
                if (snapshot.hasData && items != null) {
                  if (items.isNotEmpty) {
                    return ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (BuildContext context, int index) {
                          final Tasks tarefa = items[index];
                          return tarefa;
                        });
                  }
                  return Center(
                    child: Column(
                      children: const [
                        Icon(
                          Icons.error_outline,
                          size: 128,
                        ),
                        Text(
                          "não há nenhuma tarefa",
                          style: TextStyle(fontSize: 32),
                        )
                      ],
                    ),
                  );
                }
                return const Text("Erro ao carregar tarefas ");
            }
            return const Text("Texto desconhecido ");
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (contextNew) => FormScreen(
                taskContext: context,
              ),
            ),
          ).then((value) => setState(
                () {
                  print("Recarregando a tela inicial");
                },
              ));
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
