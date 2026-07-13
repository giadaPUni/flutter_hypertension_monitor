import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import 'package:flutter_hypertension_monitor/core/navigation/app_routes.dart';
import 'package:flutter_hypertension_monitor/core/user/current_user_provider.dart';
import 'package:flutter_hypertension_monitor/features/auth/auth_service_provider.dart';

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

  void _login() {

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
        errorMessage = 'Invalid username or password'; 
      }); 

      return; 

    }

    ref.read(
      currentUserProvider.notifier, 
    ).login(
      user, 
    ); 

    Navigator.pushReplacementNamed(
      context, 
      AppRoutes.home, 
    ); 

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(

        child: Padding(

          padding: const EdgeInsets.all(24), 

          child: Column(

            mainAxisSize: MainAxisSize.min, 

            children: [

              TextField(

                controller: usernameController, 

                decoration: const InputDecoration(

                  labelText: 'Username', 

                ), 

              ), 

              const SizedBox(
                height: 16, 
              ), 

              TextField(

                controller: passwordController, 

                obscureText: true, 

                decoration: const InputDecoration(

                  labelText: 'Password',

                ), 

              ),

              const SizedBox(
                height: 24, 
              ), 

              if (errorMessage != null)
                Text(

                  errorMessage!, 

                  style: TextStyle(

                    color: Theme.of(context)
                      .colorScheme
                      .error, 
                  ), 

                ), 

                const SizedBox(
                  height: 16, 
                ), 

                ElevatedButton(

                  onPressed: _login,

                  child: const Text(
                    'Login', 
                  ), 

                ), 

            ], 

          ), 

        ), 

      ),

    );

  }


}



