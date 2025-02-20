

import 'package:flutter/material.dart';
import 'package:todo_new/config/Routes/routes.dart';
import 'package:todo_new/screen/screens.dart';
import 'package:todo_new/config/themes/app_themes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_new/data/data.dart';
import 'package:todo_new/providers/theme_provider.dart';
class TodoApp extends ConsumerWidget{
  const TodoApp ({super.key});


@override 
Widget build(BuildContext context, WidgetRef ref){
  final routeConfig = ref.watch(routesProvider);
  
  return MaterialApp.router(
    debugShowCheckedModeBanner: false,
    theme: AppThemes.light,
    darkTheme: AppThemes.dark,
    themeMode: ref.watch(themeProvider) ? ThemeMode.dark: ThemeMode.light,
    routerConfig: routeConfig,
  );
}
}