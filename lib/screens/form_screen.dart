import 'package:alura_flutter_curso_1/components/task.dart';
import 'package:alura_flutter_curso_1/data/task_dao.dart';
import 'package:alura_flutter_curso_1/data/task_inherited.dart';
import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({
    Key? key,
    required this.taskContext,
  }) : super(key: key);
  final BuildContext taskContext;

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController difficultyController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool valueValidator(String? value) {
    if (value != null && value.isEmpty) {
      return true;
    }
    return false;
  }

  bool difficultyValidator(String? value) {
    if (value != null && value.isEmpty) {
      if (int.parse(value) > 5 || int.parse(value) < 1) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Nova Tarefa'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 3)),
              height: 730,
              width: 375,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (String? value) {
                          if (valueValidator(value)) {
                            return 'Insira o nome da Tarefa';
                          }
                          return null;
                        },
                        controller: nameController,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Nome",
                            fillColor: Colors.white70,
                            filled: true),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (value) {
                          if (difficultyValidator(value)) {
                            return 'Insira uma Dificuldade entre 1 e 5';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        controller: difficultyController,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Dificuldade",
                            fillColor: Colors.white70,
                            filled: true),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (value) {
                          if (valueValidator(value)) {
                            return 'Insira o URL da Imagem';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.url,
                        onChanged: (text) {
                          setState(() {});
                        },
                        controller: imageController,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "URL da imagem",
                            fillColor: Colors.white70,
                            filled: true),
                      ),
                    ),
                    Container(
                      height: 120,
                      width: 82,
                      decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 2,
                          color: Colors.blue,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          imageController.text,
                          errorBuilder: (BuildContext context, Object exepition,
                              StackTrace? stackTrace) {
                            return Image.asset('assets/notImage.png');
                          },
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // print(nameController.text);
                          // print(difficultyController.text);
                          // print(imageController.text);
                          TaskDao().save(Tasks(
                            nameController.text,
                            imageController.text,
                            dificuldade: int.parse(difficultyController.text),
                          ));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.green,
                              content: Text("Salvando nova tarefa"),
                            ),
                          );
                          Navigator.pop(context);
                        }
                        // print(nameController.text);
                      },
                      child: const Text("Adicionar"),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
