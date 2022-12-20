import 'package:alura_flutter_curso_1/components/task.dart';
import 'package:alura_flutter_curso_1/data/database.dart';
import 'package:sqflite/sqflite.dart';

class TaskDao {
  static const String tableSql = 'CREATE TABLE $_tablename('
      '$_name TEXT, '
      '$_difficulty INTEGER, '
      '$_image TEXT)';

  static const String _tablename = "taskTable";
  static const String _name = "name";
  static const String _difficulty = "difficulty";
  static const String _image = "image";

  /*------------Criar Tarefas ------------*/

  save(Tasks tarefa) async {
    print("iniciando o save: ");
    final Database bancosDeDados = await getDatabase();
    var itemExist = await find(tarefa.nome);
    Map<String, dynamic> taskMap = toMap(tarefa);

    if (itemExist.isEmpty) {
      print("a tarefa não Existia.");
      return await bancosDeDados.insert(_tablename, taskMap);
    } else {
      print("a tarefa já exixtia");
      return await bancosDeDados.update(_tablename, taskMap,
          where: '$_name = ?', whereArgs: [tarefa.nome]);
    }
  }

  Map<String, dynamic> toMap(Tasks tarefa) {
    print("convertendo tarefa em map");
    final Map<String, dynamic> mapaDeTarefas = {};
    mapaDeTarefas[_name] = tarefa.nome;
    mapaDeTarefas[_difficulty] = tarefa.dificuldade;
    mapaDeTarefas[_image] = tarefa.foto;
    print("Mapa de arefa: $mapaDeTarefas");
    return mapaDeTarefas;
  }

  /*------------Buscar varias Tarefas ------------*/

  Future<List<Tasks>> findAll() async {
    print("acessando o findAll");
    final Database bancosDeDados = await getDatabase();
    final List<Map<String, dynamic>> result =
        await bancosDeDados.query(_tablename);
    print("procurando dados no banco de dados ... encontrado: $result");
    return toList(result);
  }

  List<Tasks> toList(List<Map<String, dynamic>> mapaDeTarefas) {
    print("Convertendo to list");
    final List<Tasks> tarefas = [];
    for (Map<String, dynamic> linha in mapaDeTarefas) {
      final Tasks tarefa =
          Tasks(linha[_name], linha[_image], dificuldade: linha[_difficulty]);
      tarefas.add(tarefa);
    }
    print("lista de Tarefas $tarefas");
    return tarefas;
  }

  /*------------Buscar por uma Tarefas ------------*/

  Future<List<Tasks>> find(String nomeDaTarefa) async {
    print("acessando Find: ");
    final Database bancosDeDados = await getDatabase();
    final List<Map<String, dynamic>> result = await bancosDeDados
        .query(_tablename, where: '$_name = ?', whereArgs: [nomeDaTarefa]);
    print("tarefa encontrada: ${toList(result)}");
    return toList(result);
  }

  /*------------Deletar Tarefas ------------*/

  delete(String nomeDaTarefa) async {
    print('Deletando tarefa: $nomeDaTarefa');
    final Database bancoDeDados = await getDatabase();
    return await bancoDeDados.delete(
      _tablename,
      where: '$_name = ?',
      whereArgs: [nomeDaTarefa],
    );
  }
}
