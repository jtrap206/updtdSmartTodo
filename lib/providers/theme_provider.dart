import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_new/data/data.dart';

class ThemeNotifier extends StateNotifier<bool> {
  final TaskDatasource taskDatasource;
  ThemeNotifier(this.taskDatasource) : super(false){
  _loadTheme();
  }

  Future<void> _loadTheme() async{
    state = await taskDatasource.getTheme();
  }

  Future<void> toggleTheme() async{
    state = !state;
    await taskDatasource.saveTheme(state);
  }
  // <--- Error here
}

final themeProvider = StateNotifierProvider<ThemeNotifier, bool>(
    (ref) => ThemeNotifier(TaskDatasource()),
   ); 