import 'package:flutter/material.dart';
import 'package:todo_new/data/data.dart';
import 'package:todo_new/utils/extensions.dart';
import 'package:todo_new/utils/utils.dart';
import 'common_containers.dart';
import 'package:todo_new/widgets/widgets.dart';


class DisplayListOfTasks extends StatelessWidget{
  const DisplayListOfTasks ({
    super.key,
    required this.tasks,
    this.isCompletedTasks = false,
    });

  final List<Task> tasks;
  final bool isCompletedTasks;

  @override
  Widget build(BuildContext context){
    final deviceSize = context.deviceSize;
    final height = isCompletedTasks ? deviceSize.height * 0.25 : deviceSize.height * 0.3;
    final emptyTasksMessage = isCompletedTasks ? 'There is no completed task yet' : 'there is no task to do!';
    return  CommonContainers(
          height: height,
          child: tasks.isEmpty? 
          Center(
            child: Text(
            emptyTasksMessage, style: context.textTheme.headlineSmall
          ),
          ):
          ListView.separated(
              shrinkWrap: true, 
              itemCount: tasks.length,
              padding: EdgeInsets.zero,
              itemBuilder: (ctx, index){
                final task = tasks[index];
              return InkWell(
                onLongPress: () {

                },
                onTap: () async{
                  await showModalBottomSheet(
                    context: context, 
                    builder: (ctx){
                      return TaskDetails(task: task);
                    });

                },
                child: TaskTile(task: task)
                );

                }, separatorBuilder: (BuildContext context, int index) { 
                  return const Divider(thickness: 2.0,);
                 },
               ),


            );

  }
}