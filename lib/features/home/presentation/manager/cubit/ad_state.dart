import 'package:equatable/equatable.dart';
import '../../../data/models/ad_model.dart';

abstract class AdState extends Equatable {
  const AdState();

  @override
  List<Object?> get props => [];
}

class AdInitial extends AdState {}

class AdLoading extends AdState {}

class AdLoaded extends AdState {
  final List<AdModel> ads;

  const AdLoaded({required this.ads});

  @override
  List<Object?> get props => [ads];
}

class AdError extends AdState {
  final String error;

  const AdError({required this.error});

  @override
  List<Object?> get props => [error];
}
