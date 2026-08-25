import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import 'package:flutter_hypertension_monitor/core/navigation/app_routes.dart';
import 'package:flutter_hypertension_monitor/core/user/current_user_provider.dart';
import 'package:flutter_hypertension_monitor/features/auth/auth_service_provider.dart';
import 'package:flutter_hypertension_monitor/core/auth/current_session.dart';

class LoginPage extends ConsumerStatefulWidget {

  const LoginPage({
    super.key,
  });

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState(); 

}

class _LoginPageState extends ConsumerState<LoginPage> {

  final usernameController = TextEditingController(); 

  final passwordController = TextEditingController(); 

  String? errorMessage; 

  
  
  @override
  void dispose() {

    usernameController.dispose(); 

    passwordController.dispose(); 

    super.dispose(); 

  }

  Future<void> _login() async {

    final username = usernameController.text.trim(); 

    final password = passwordController.text.trim(); 

    final authService = ref.read(
      authServiceProvider, 
    ); 

    final user = authService.login(
      username, 
      password, 
    ); 


    if (user == null) {
      setState(() {
        errorMessage = 'Username o password non validi'; 
      }); 

      return; 

    }


    ref.read(
      currentUserProvider.notifier, 
    ).login(
      user, 
    ); 

    // save current user id 
    await ref.read(
      currentSessionProvider, 
    ).saveCurrentUserId(
      user.id, 
    ); 

    if (!mounted) {
      return; 
    }

    Navigator.pushReplacementNamed(
      context, 
      AppRoutes.home, 
    ); 

  }

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme; 

    return PopScope(

      canPop: false, 

      child: Scaffold(
        backgroundColor: colors.surfaceContainerLowest, 
        body: SafeArea(
          child: Center(

            child: SingleChildScrollView(

              padding: const EdgeInsets.all(24), 

              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 420,
                ),

                child: Card(

                  child: Padding(
                    padding: const EdgeInsets.all(28),
                    child: Column (
                      mainAxisSize: MainAxisSize.min, 

                      children: [
                        Container(
                          width: 72, 
                          height: 72, 
                          decoration: BoxDecoration(
                            color: colors.primaryContainer, 
                            shape: BoxShape.circle, 
                          ), 

                          child: Icon(
                            Icons.monitor_heart_outlined, 
                            size: 40, 
                            color: colors.onPrimaryContainer,
                          ),
                        ),

                        const SizedBox(height: 20), 

                        Text(
                          'Hypertension Monitor', 
                          textAlign: TextAlign.center, 
                          style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                        ), 

                        const SizedBox(height: 8), 

                        Text(
                          'Accedi per monitorare la pressione arteriosa',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                            .textTheme
                            .bodyMedium,                          
                        ), 

                        const SizedBox(height: 28), 

                        TextField(

                          controller: usernameController, 
                          textInputAction: TextInputAction.next, 
                          decoration: const InputDecoration(
                            labelText: 'Username', 
                            prefixIcon: Icon(
                              Icons.person_outline,
                            ), 

                          ), 

                        ), 

                        const SizedBox(height: 16), 

                        TextField(
                          controller: passwordController, 
                          obscureText: true, 
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) => _login(),
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(
                              Icons.lock_outline, 
                            ), 
                          ), 

                        ), 

                        if (errorMessage != null) ...[
                          const SizedBox(height: 16),

                          Text(
                            errorMessage!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: colors.error,
                            ),
                          ),
                        ],
                        const SizedBox(height: 24), 

                        SizedBox(
                          width: double.infinity, 
                          child: FilledButton.icon(
                            onPressed: _login,
                            icon: const Icon(
                              Icons.login,
                            ),
                            label: const Text(
                              'Accedi',
                            ),
                          ),                          
                        ),
                        const SizedBox(height: 12),

                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.register,
                              );
                            },
                            child: const Text(
                              'Crea un account',
                            ),
                          ),
                        ),

                      ],                       
                    ),
                  ),
                ), 
              ), 

            ), 

          ),

        )

      ), 

    );

  }


}



