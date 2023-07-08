part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class ProfileLoading extends ProfileEvent {}

class ProfileLoadEvent extends ProfileEvent {}
