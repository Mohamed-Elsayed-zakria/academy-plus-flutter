import 'package:get_it/get_it.dart';
import '../../features/universities/data/repository/universities_repo.dart';
import '../../features/universities/data/repository/universities_implement.dart';
import '../../features/universities/presentation/manager/cubit/universities_cubit.dart';
import '../../features/auth/data/repository/register_repo.dart';
import '../../features/auth/data/repository/register_implement.dart';
import '../../features/auth/presentation/manager/cubit/register_cubit.dart';
import '../../features/auth/data/repository/login_repo.dart';
import '../../features/auth/data/repository/login_implement.dart';
import '../../features/auth/presentation/manager/cubit/login_cubit.dart';
import '../../features/auth/data/repository/otp_repo.dart';
import '../../features/auth/data/repository/otp_implement.dart';
import '../../features/auth/presentation/manager/cubit/otp_cubit.dart';
import '../../features/auth/presentation/manager/cubit/forgot_password_cubit.dart';
import '../../features/auth/presentation/manager/cubit/reset_password_cubit.dart';
import '../../features/auth/data/repository/profile_repo.dart';
import '../../features/auth/data/repository/profile_implement.dart';
import '../../features/auth/presentation/manager/cubit/profile_picture_cubit.dart';

class SetupLocator {
  static GetIt locator = GetIt.instance;
  void setup() {
    // Universities
    locator.registerLazySingleton<UniversitiesRepo>(() => UniversitiesImplement());
    locator.registerFactory(() => UniversitiesCubit(locator()));

    // Register
    locator.registerLazySingleton<RegisterRepo>(() => RegisterImplement());
    locator.registerFactory(() => RegisterCubit(locator()));

    // Login
    locator.registerLazySingleton<LoginRepo>(() => LoginImplement());
    locator.registerFactory(() => LoginCubit(locator()));

    // OTP
    locator.registerLazySingleton<OtpRepo>(() => OtpImplement());
    locator.registerFactory(() => OtpCubit(locator()));

    // Forgot Password
    locator.registerFactory(() => ForgotPasswordCubit(locator()));

    // Reset Password
    locator.registerFactory(() => ResetPasswordCubit(locator<OtpRepo>()));

    // Profile
    locator.registerLazySingleton<ProfileRepo>(() => ProfileImplement());
    locator.registerFactory(() => ProfilePictureCubit(locator()));
  }
}