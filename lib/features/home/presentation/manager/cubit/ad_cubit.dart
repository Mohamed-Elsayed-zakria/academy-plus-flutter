import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/errors/server_failures.dart';
import '../../../data/models/ad_model.dart';
import '../../../data/repository/ad_repo.dart';
import 'ad_state.dart';

class AdCubit extends Cubit<AdState> {
  AdCubit(this._adRepo) : super(AdInitial());
  final AdRepo _adRepo;

  Future<void> getAllAds() async {
    emit(AdLoading());
    Either<Failures, List<AdModel>> result = await _adRepo.getAllAds();
    result.fold(
      (failures) => emit(AdError(error: failures.errMessage)),
      (ads) => emit(AdLoaded(ads: ads)),
    );
  }

  Future<void> getAdsByUniversity(String universityId) async {
    emit(AdLoading());
    Either<Failures, List<AdModel>> result = await _adRepo.getAdsByUniversity(universityId);
    result.fold(
      (failures) => emit(AdError(error: failures.errMessage)),
      (ads) => emit(AdLoaded(ads: ads)),
    );
  }

  Future<void> getAdById(String adId) async {
    emit(AdLoading());
    Either<Failures, AdModel> result = await _adRepo.getAdById(adId);
    result.fold(
      (failures) => emit(AdError(error: failures.errMessage)),
      (ad) => emit(AdLoaded(ads: [ad])),
    );
  }
}
