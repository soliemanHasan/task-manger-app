import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manger_app/core/core_component/app_button.dart';
import 'package:task_manger_app/core/core_component/show_snack_bar.dart';
import 'package:task_manger_app/core/paths/images_paths.dart';
import 'package:task_manger_app/generated/locale_keys.g.dart';
import 'package:task_manger_app/modules/home/presentation/routes/items_pagination_route.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/utils/app_validator.dart';
import '../../../../core/utils/base_state.dart';
import '../../domain/entities/user_entity.dart';
import '../blocs/login/login_bloc.dart';
import '../components/auth_text_form_fields.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LoginBloc>(),
      child: BlocConsumer<LoginBloc, BaseState<UserEntity>>(
        listener: _loginListener,
        builder: (context, state) => Scaffold(
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  /* ---------------------------------- image ---------------------------------- */
                  SizedBox(
                    height: 45.h,
                  ),
                  Image.asset(
                    ImagesPaths.login,
                    fit: BoxFit.cover,
                  ),
                  /* ------------------------------- login text ------------------------------- */
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        LocaleKeys.enterYouDataToContinue.tr(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),

                  /* ---------------------------- phone text field ---------------------------- */
                  AuthTextFormField(
                    prefixIcon: const Icon(Icons.person_2_outlined),
                    controller: userNameController,
                    validator: AppValidator.nameValidator,
                    hint: LocaleKeys.enterYourName.tr(context: context),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  /* -------------------------------- password -------------------------------- */
                  AuthTextFormField(
                    prefixIcon: const Icon(Icons.lock),
                    controller: passwordController,
                    hint: LocaleKeys.enterPassword.tr(context: context),
                    validator: AppValidator.passwordValidator,
                    isPass: true,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  /* ------------------------------ login button ------------------------------ */
                  AppButton(
                      height: 40.h,
                      width: 320.w,
                      label: LocaleKeys.login,
                      loading: state.isLoading,
                      onTap: () => _loginPressed(context, state)),
                  //text button
                  SizedBox(
                    height: 10.h,
                  ),
                  /* ---------------------- navigate to register button ---------------------- */
                  TextButton(
                      onPressed: () => null,
                      child: Row(
                        children: [
                          // TODO
                          Text(
                            //ToDo
                            LocaleKeys.doNotHaveAnAccount.tr(context: context),
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          Text(
                            //ToDo
                            LocaleKeys.register,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _loginPressed(BuildContext context, BaseState<UserEntity> state) {
    if (!(formKey.currentState!.validate()) || state.isLoading) return;

    context.read<LoginBloc>().add(
          LoginButtonTappedEvent(
            password: passwordController.text,
            phoneNumber: userNameController.text,
          ),
        );

    context.go(ItemsPaginationRoute.name);
  }

  void _loginListener(BuildContext context, BaseState<UserEntity> state) {
    if (state.isError) showSnackBar(context, state.errorMessage);

    if (state.isSuccess) {
      //  context.go(MainRoute.name);
      showSnackBar(context, LocaleKeys.loginDone.tr());
    }
    state.isLoading;
  }
}
