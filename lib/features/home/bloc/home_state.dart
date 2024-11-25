part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadedState extends HomeState {
  final List<Map<String, dynamic>> taskList;

  HomeLoadedState({required this.taskList});
}
