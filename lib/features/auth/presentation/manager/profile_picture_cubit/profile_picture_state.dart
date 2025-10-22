import 'dart:io';

abstract class ProfilePictureState {}

final class ProfilePictureInitial extends ProfilePictureState {
  final File? profileImage;

  ProfilePictureInitial({
    this.profileImage,
  });

  ProfilePictureInitial copyWith({
    File? profileImage,
  }) {
    return ProfilePictureInitial(
      profileImage: profileImage ?? this.profileImage,
    );
  }
}

final class ProfilePictureLoading extends ProfilePictureState {
  final File? profileImage;

  ProfilePictureLoading({
    required this.profileImage,
  });
}

final class ProfilePictureSuccess extends ProfilePictureState {
  final File? profileImage;

  ProfilePictureSuccess({
    required this.profileImage,
  });
}

final class ProfilePictureError extends ProfilePictureState {
  final String error;
  final File? profileImage;

  ProfilePictureError({
    required this.error,
    required this.profileImage,
  });
}
