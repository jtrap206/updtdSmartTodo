import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:todo_new/config/Routes/route_location.dart';
import 'package:todo_new/data/data.dart';
import 'package:todo_new/providers/providers.dart';
import 'package:todo_new/utils/utils.dart';
import 'package:todo_new/widgets/display_list_of_tasks.dart';
import 'package:todo_new/widgets/display_white_text.dart';
//import 'package:todo_new/widgets/widgets.dart';
import 'package:gap/gap.dart';
import 'package:todo_new/widgets/widgets.dart';


class HomeScreen extends ConsumerWidget{
  static HomeScreen builder(BuildContext context, GoRouterState state) =>
  const HomeScreen();
  const HomeScreen({super.key});
  

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final colors = context.colorScheme;
    final deviceSize = context.deviceSize;
    final taskState = ref.watch(taskProvider);
    final completedTasks = _completedTasks( taskState.tasks, ref);
    final incompletedTasks = _incompletedTasks( taskState.tasks, ref);
    final selectedDate = ref.watch(dateProvider);


    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: deviceSize.height * 0.3,
                width: deviceSize.width,
                color: colors.primary,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   InkWell (
                    onTap: () => Helpers.selectDate(context, ref),
                      child: DisplayWhiteText(
                        text: DateFormat.yMMMd().format(selectedDate),
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const DisplayWhiteText(
                      text: "SMART.TODO!",
                      fontSize: 40,
                    
                    )
                  ],
                ),
              ),
            ],
          ),
            Positioned(
              top: 130,
              left: 0,
              right: 0,
              child: SafeArea(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      DisplayListOfTasks(

                      tasks: incompletedTasks,
                      
                        
                       
                      
                      ),
                     
                      
                      const Gap(20),
                      Text('completed',
                      style: context.textTheme.headlineMedium,
                      ),
                      const Gap(20),
                      DisplayListOfTasks(

                        tasks: completedTasks,
                          
                        

                         
                        isCompletedTasks: true,
                        ),
                      
                      const Gap(20),
                      ElevatedButton(
                        style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(colors.primary)),
                      
                        onPressed: () => context.push(RouteLocation.createTask),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0), 
                          child:  DisplayWhiteText(text: 'add new'),
                        ),
                        )
                    ],
                  ),
                ),
              )
            
            )
        ],
      ),
    );
  
  }
  List<Task> _completedTasks(List<Task> tasks, WidgetRef ref){
    final SelectedDate = ref.watch(dateProvider);
    final List<Task> filteredTasks = [];
    for(var task in tasks){
    final isTaskDay = Helpers.isTaskFromSelectedDate(task, SelectedDate);
    if(task.isCompleted && isTaskDay){
     
      filteredTasks.add(task);
      
    }
    }
    return filteredTasks;
  } 

  List<Task> _incompletedTasks(List<Task> tasks, WidgetRef ref){
    final SelectedDate = ref.watch(dateProvider);
    
    final List<Task> filteredTasks = [];
    for(var task in tasks){
    final isTaskDay = Helpers.isTaskFromSelectedDate(task, SelectedDate);
     
    if(!task.isCompleted && isTaskDay){
      filteredTasks.add(task);
    }
    }
    return filteredTasks;
  } 
}