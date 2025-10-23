import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/widgets/custom_text_field.dart';
import '../../../../../../core/widgets/custom_phone_input.dart';
import '../../../../../../core/widgets/university_selector_widget.dart';
import '../../../../../universities/presentation/manager/cubit/universities_cubit.dart';
import '../../../../../universities/presentation/manager/cubit/universities_state.dart';
import '../../../manager/register_cubit/register_cubit.dart';
import '../../../manager/register_cubit/register_state.dart';

class RegisterFormWidget extends StatelessWidget {
  const RegisterFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final registerCubit = context.read<RegisterCubit>();

    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, registerState) {
        return Form(
          key: registerCubit.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Username Field
              CustomTextField(
                label: AppLocalizations.username,
                hintText: AppLocalizations.username,
                controller: registerCubit.nameController,
                prefixIcon: const Icon(Ionicons.person_outline),
                validator: (value) {
                  return context.read<RegisterCubit>().validateName(value);
                },
              ),

              const SizedBox(height: 20),

              // Password Field
              CustomTextField(
                label: AppLocalizations.password,
                hintText: AppLocalizations.password,
                controller: registerCubit.passwordController,
                isPassword: true,
                prefixIcon: const Icon(Ionicons.lock_closed_outline),
                validator: (value) {
                  return context.read<RegisterCubit>().validatePassword(value);
                },
              ),

              const SizedBox(height: 20),

              // Confirm Password Field
              CustomTextField(
                label: AppLocalizations.confirmPassword,
                hintText: AppLocalizations.confirmPassword,
                controller: registerCubit.confirmPasswordController,
                isPassword: true,
                prefixIcon: const Icon(Ionicons.lock_closed_outline),
                validator: (value) {
                  return context.read<RegisterCubit>().validateConfirmPassword(
                    value,
                    registerCubit.passwordController.text,
                  );
                },
              ),

              const SizedBox(height: 20),

              // Phone Number Field
              BlocBuilder<RegisterCubit, RegisterState>(
                builder: (context, state) {
                  return CustomPhoneInput(
                    label: AppLocalizations.phoneNumber,
                    hintText: AppLocalizations.phoneNumber,
                    controller: registerCubit.phoneController,
                    initialCountryCode: 'EG',
                    onCountryChanged: (countryCode, dialCode) {
                      context.read<RegisterCubit>().updateDialCode(dialCode);
                    },
                    validator: (value) {
                      return context.read<RegisterCubit>().validatePhone(value);
                    },
                  );
                },
              ),

              const SizedBox(height: 20),

              // University Selection
              BlocBuilder<UniversitiesCubit, UniversitiesState>(
                builder: (context, universitiesState) {
                  return BlocBuilder<RegisterCubit, RegisterState>(
                    builder: (context, registerState) {
                      final currentState = registerState is RegisterInitial
                          ? registerState
                          : RegisterInitial();
                      return UniversitySelectorWidget(
                        selectedUniversity: currentState.selectedUniversity,
                        onUniversitySelected: (university) {
                          context
                              .read<RegisterCubit>()
                              .updateSelectedUniversity(university);
                        },
                        label: AppLocalizations.selectUniversity,
                        universities: universitiesState is UniversitiesSuccess
                            ? universitiesState.universities
                            : [],
                        isLoading: universitiesState is UniversitiesLoading,
                        hasError:
                            currentState.hasAttemptedSubmit &&
                            currentState.selectedUniversity == null,
                        errorText:
                            currentState.hasAttemptedSubmit &&
                                currentState.selectedUniversity == null
                            ? AppLocalizations.pleaseSelectUniversity
                            : null,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
