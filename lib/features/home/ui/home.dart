import 'package:alert_tastapp_bloc/features/home/bloc/home_bloc.dart';
import 'package:alert_tastapp_bloc/widgets/task_alert_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    context.read<HomeBloc>().add(TaskLoadedEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AddTaskAlertDialog(); // Pass callback
              },
            );
          },
        ),
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Text('Task List'),
          centerTitle: true,
        ),
        body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          if (state is HomeInitial) {
            return const CircularProgressIndicator();
          } else if (state is HomeLoadedState) {
            if (state.taskList.isEmpty) {
              const Text('No Text Found');
            } else {
              return ListView.separated(
                separatorBuilder: (BuildContext context, int index) => SizedBox(),
                itemCount: state.taskList.length,
                itemBuilder: (context, index) {
                  var task = state.taskList[index];
                  return ListTile(
                    title: Text(task['taskdate'] ?? 'No task name'),
                    subtitle: Text(task['taskDesc'] ?? 'No description'),
                  );
                },
              );
            }
          }
          ;
          return SizedBox.shrink();
        }));
  }
}
