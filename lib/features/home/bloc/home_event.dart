part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class TaskAddEvent extends HomeEvent {
  final String time;
  final String text;

  TaskAddEvent({required this.time, required this.text});
}

class TaskLoadedEvent extends HomeEvent{

}
