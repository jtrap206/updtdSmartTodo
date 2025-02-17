import 'package:flutter/material.dart';
import 'package:todo_new/app/todo_app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
void main() {
  runApp(
    const ProviderScope(
      child: TodoApp(),
      ),
  );
}


