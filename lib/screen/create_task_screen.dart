import 'package:flutter/material.dart';
import 'package:todo_new/data/data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo_new/config/Routes/routes.dart';
import 'package:todo_new/data/models/task.dart';
import 'package:todo_new/providers/providers.dart';
import 'package:todo_new/utils/utils.dart';
import 'package:todo_new/widgets/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:gap/gap.dart';

class CreateTaskScreen extends ConsumerStatefulWidget {
  static CreateTaskScreen builder(BuildContext context, GoRouterState state) =>
  const CreateTaskScreen();
  const CreateTaskScreen({super.key});

  @override
 ConsumerState<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends ConsumerState<CreateTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  @override
  void dispose(){
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }
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
              CommonTextFields(
                title: 'Task Title',
                hintText: 'Task Title',
                controller: _titleController,
              ),
              const Gap(16),
              const SelectCategory(),
              const Gap(16),
             const SelectDateTime(),
        
              const Gap(16),
              CommonTextFields(
                title: 'Notes',
                hintText: 'Task Note',
                maxLines: 6,
                controller: _noteController,
              ),
              const Gap(30),
              ElevatedButton(
                style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.pink)),
                onPressed: _createTask, 
                child: const DisplayWhiteText(text: 'Save')
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _createTask() async {
    final title = _titleController.text.trim();
    final note = _noteController.text.trim();
    final date = ref.watch(dateProvider);
    final time = ref.watch(timeProvider);
    final category = ref.watch(categoryProvider);

    if (title.isNotEmpty){
      final task = Task(
        title: title, 
        note: note, 
        time: Helpers.timeToString(time), 
        date: DateFormat.yMMMd().format(date), 
        category: category, 
        isCompleted: false,
        );

        await ref.read(taskProvider.notifier).addTask(task).then((value){
          AppAlerts.displaySnackBar(context, 'Task created successfully');
          context.go(RouteLocation.home);
        });
    }else{
      AppAlerts.displaySnackBar(context, 'Task title cannot be empty');
    }

  }
}