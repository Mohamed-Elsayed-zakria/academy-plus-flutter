import 'package:equatable/equatable.dart';
import '../../../data/models/user_profile_model.dart';

abstract class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object?> get props => [];
}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class EditProfileLoaded extends EditProfileState {
  final UserProfileModel profile;

  const EditProfileLoaded({required this.profile});

  @override
  List<Object?> get props => [profile];
}

class EditProfileSuccess extends EditProfileState {
  final UserProfileModel profile;

  const EditProfileSuccess({required this.profile});

  @override
  List<Object?> get props => [profile];
}

class EditProfileError extends EditProfileState {
  final String error;

  const EditProfileError({required this.error});

  @override
  List<Object?> get props => [error];
}
