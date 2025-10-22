import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/widgets/custom_text_field.dart';
import '../../../../../../core/widgets/custom_phone_input.dart';
import '../../../../../../core/utils/navigation_helper.dart';
import '../../../manager/login_cubit/login_cubit.dart';
import '../../../manager/login_cubit/login_state.dart';


class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();
    
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, loginState) {
        return Form(
          key: loginCubit.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Phone Number Field
              CustomPhoneInput(
                label: AppLocalizations.phoneNumber,
                hintText: AppLocalizations.phoneNumber,
                controller: loginCubit.phoneController,
                initialCountryCode: 'EG',
                onCountryChanged: (countryCode, dialCode) {
                  context.read<LoginCubit>().updateDialCode(dialCode);
                },
                validator: (value) {
                  return context.read<LoginCubit>().validatePhone(value);
                },
              ),

              const SizedBox(height: 20),

              // Password Field
              CustomTextField(
                label: AppLocalizations.password,
                hintText: AppLocalizations.password,
                controller: loginCubit.passwordController,
                isPassword: true,
                prefixIcon: const Icon(Ionicons.lock_closed_outline),
                validator: (value) {
                  return context.read<LoginCubit>().validatePassword(value);
                },
              ),
              const SizedBox(height: 16),
              // Forgot Password Link
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    NavigationHelper.to(
                      path: '/forgot-password',
                      context: context,
                    );
                  },
                  child: Text(
                    AppLocalizations.forgotPassword,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
