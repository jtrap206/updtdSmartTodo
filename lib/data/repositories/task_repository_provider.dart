import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_new/data/data.dart';
import 'package:todo_new/data/repositories/repositories.dart';

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  final datasource = ref.watch(taskDatasourceProvider);
  return TaskRepositoryImpl(datasource);
});