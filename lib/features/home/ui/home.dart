import 'package:alert_tastapp_bloc/features/home/bloc/home_bloc.dart';
import 'package:alert_tastapp_bloc/widgets/task_alert_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    context.read<HomeBloc>().add(TaskLoadedEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AddTaskAlertDialog(); // Pass callback
            },
          );
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Task List'),
        centerTitle: true,
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeInitial) {
            return const CircularProgressIndicator();
          } else if (state is HomeLoadedState) {
            if (state.taskList.isEmpty) {
              const Text('No Text Found');
            } else {
              return ListView.separated(
                padding: EdgeInsets.all(10),
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 10,),
                itemCount: state.taskList.length,
                itemBuilder: (context, index) {
                  var task = state.taskList[index];

                  return ListTile(
                    //shape: RoundedRectangleBorder(),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    minLeadingWidth: 50,
                    tileColor: Colors.teal.shade100,
                    title: Text(task['taskdate'] ?? 'No task name'),
                    subtitle: Text(task['taskDesc'] ?? 'No description'),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete_forever,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        context
                            .read<HomeBloc>()
                            .add(TaskDeleteEvent(taskKey: task['key']));
                      },
                    ),
                  );
                },
              );
            }
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
