import 'package:study_mate/features/home/domain/entity/home_enitiy.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final HomeData data;
  HomeLoaded(this.data);
}

class HomeError extends HomeState {}