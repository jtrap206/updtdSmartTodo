import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_new/config/Routes/route_location.dart';
import 'package:todo_new/data/models/task.dart';
import 'package:todo_new/utils/utils.dart';
import 'package:todo_new/widgets/display_list_of_tasks.dart';
import 'package:todo_new/widgets/display_white_text.dart';
//import 'package:todo_new/widgets/widgets.dart';
import 'package:gap/gap.dart';


class HomeScreen extends StatelessWidget{
  static HomeScreen builder(BuildContext context, GoRouterState state) =>
  const HomeScreen();
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context){
    final Colors = context.colorScheme;
    final deviceSize = context.deviceSize;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: deviceSize.height * 0.3,
                width: deviceSize.width,
                color: Colors.primary,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DisplayWhiteText(
                      text: "feb 6th 2025",
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                    DisplayWhiteText(
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
                     const DisplayListOfTasks(
                      tasks: [
                        Task(
                          title: 'title 1',
                          note: 'note',
                          time: '10:33',
                          date: 'feb,11',
                          isCompleted: false,
                          category: TaskCategories.shopping,

                        ),

                        Task(
                          title: 'title 2 title 2',
                          note: 'note',
                          time: '13:30',
                          date: 'feb,11',
                          isCompleted: false,
                          category: TaskCategories.education,

                        )
                      ], 
                      
                      ),
                     
                      
                      const Gap(20),
                      Text('completed',
                      style: context.textTheme.headlineMedium,
                      ),
                      const Gap(20),
                      const DisplayListOfTasks(
                        tasks:[
                          Task(
                          title: 'title 1',
                          note: 'note',
                          time: '10:33',
                          date: 'feb,11',
                          isCompleted: true,
                          category: TaskCategories.personal,

                        ),
                         Task(
                          title: 'title 2 title 2',
                          note: 'note',
                          time: '13:30',
                          date: 'feb,11',
                          isCompleted: true,
                          category: TaskCategories.work,

                        )

                        ], 
                        isCompletedTasks: true,
                        ),
                      
                      const Gap(20),
                      ElevatedButton(
                        style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.primary)),
                      
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
}