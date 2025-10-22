import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/widgets/custom_phone_input.dart';
import '../../../manager/forgot_password_cubit/forgot_password_cubit.dart';
import '../../../manager/forgot_password_cubit/forgot_password_state.dart';

class ForgotPasswordFormWidget extends StatelessWidget {
  final TextEditingController phoneController;
  
  const ForgotPasswordFormWidget({
    super.key,
    required this.phoneController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
      builder: (context, forgotPasswordState) {
        return Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Phone Number Field
              CustomPhoneInput(
                label: AppLocalizations.phoneNumber,
                hintText: AppLocalizations.phoneNumber,
                controller: phoneController,
                initialCountryCode: 'EG',
                onCountryChanged: (countryCode, dialCode) {
                  context.read<ForgotPasswordCubit>().updateDialCode(dialCode);
                },
                validator: (value) {
                  return context.read<ForgotPasswordCubit>().validatePhone(value);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
