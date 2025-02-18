import 'package:todo_new/data/models/task.dart';

abstract class TaskRepository {
  Future<void>addTask(Task task);
  Future<void>updateTask(Task task);
  Future<void>deleteTask(Task task);
  Future<List<Task>>getAllTask();

}