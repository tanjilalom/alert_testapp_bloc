part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class TaskAddEvent extends HomeEvent {
  final String time;
  final String text;

  TaskAddEvent({required this.time, required this.text});
}

class TaskLoadedEvent extends HomeEvent {}

class TaskDeleteEvent extends HomeEvent {
  final int taskKey; // The key of the task to be deleted

  TaskDeleteEvent({required this.taskKey});
}
