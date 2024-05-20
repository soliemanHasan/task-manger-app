import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/service_locator.dart';
import '../../../../core/utils/base_state.dart';
import '../../domain/entities/user_entity.dart';
import '../blocs/login/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // provided a bloc
    return BlocProvider(
      create: (context) => sl<LoginBloc>(),
      // listen to bloc state changes
      child: BlocListener<LoginBloc, BaseState<UserEntity>>(
        listener: _loginListener,
        // build screen by bloc builder
        child: BlocBuilder<LoginBloc, BaseState<UserEntity>>(
          builder: (context, state) {
            ///
            /// ... your screen
            //TODO : implement your screen
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  void _loginListener(BuildContext context, BaseState<UserEntity> state) {
    // TODO: implement listen cases
  }
}
