import 'package:flutter/material.dart';
import 'package:todo_new/widgets/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:gap/gap.dart';

class CreateTaskScreen extends StatelessWidget {
  static CreateTaskScreen builder(BuildContext context, GoRouterState state) =>
  const CreateTaskScreen();
  const CreateTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DisplayWhiteText(text: 'Add New Task'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const CommonTextFields(
                title: 'Task Title',
                hintText: 'Task Title',
              ),
              const Gap(16),
              const SelectCategory(),
              const Gap(16),
             const SelectDateTime(),
        
              const Gap(16),
              const CommonTextFields(
                title: 'Task Title',
                hintText: 'Task Note',
                maxLines: 6,
              ),
              const Gap(30),
              ElevatedButton(
                style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.pink)),
                onPressed: () {}, 
                child: const DisplayWhiteText(text: 'Save')
                )
            ],
          ),
        ),
      ),
    );
  }
}