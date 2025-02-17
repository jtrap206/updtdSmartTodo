import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_new/config/Routes/route_location.dart';
import 'package:todo_new/screen/home_screen.dart';
import 'package:todo_new/screen/screens.dart';

final navigationKey = GlobalKey<NavigatorState>();
final appRoutes = [
  GoRoute(
    path: RouteLocation.home,
    parentNavigatorKey: navigationKey,
    builder: HomeScreen.builder,
  ),

   GoRoute(
    path: RouteLocation.createTask,
    parentNavigatorKey: navigationKey,
    builder: CreateTaskScreen.builder,
  ),
];