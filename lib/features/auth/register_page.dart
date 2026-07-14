import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_hypertension_monitor/core/user/user_role.dart';
import 'package:flutter_hypertension_monitor/features/auth/auth_service_provider.dart';
import 'package:flutter_hypertension_monitor/core/user/current_user_provider.dart';
import 'package:flutter_hypertension_monitor/core/navigation/app_routes.dart';

/// Registration page.
///
/// Allows the user to:
/// - create an application account through AuthService;
/// - choose how the application will be used: 
///   - User handling one or more patients 
///   - Patient monitoring own values 
/// 



class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({
    super.key,
  });

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {

  final _formKey = GlobalKey<FormState>();

  UserRole _selectedRole = UserRole.patient;

  final _usernameController = TextEditingController();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _confirmPasswordController = TextEditingController();


  @override
  void dispose() {

    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }


  void _register() {

    if (!_formKey.currentState!.validate()) {
      return;
    }

    final username = _usernameController.text.trim(); 

    final email = _emailController.text.trim();

    final password = _passwordController.text; 

    final role = _selectedRole; 


    final authService = ref.read(
      authServiceProvider, 
    ); 

    final user = authService.register(

      username: username, 

      email: email, 

      password: password, 

      role: _selectedRole, 

    ); 


    if (user == null) {

      ScaffoldMessenger.of(context)
        .showSnackBar(
          const SnackBar(
            content: Text(
              'Username o email già esistente', 
            ), 
          ), 
        ); 

        return; 

    }

    ref.read(
      currentUserProvider.notifier, 
    )
    .login(
      user, 
    ); 


    ScaffoldMessenger.of(context)
      .showSnackBar(

        const SnackBar(

          content: Text(
            'Registrazione completata con successo',
          ),

        ),

    );

    Navigator.pushReplacementNamed(
      context, 
      AppRoutes.home,
    ); 

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'Crea account',
        ),
      ),

      body: SafeArea(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(24),

          child: Center(

            child: ConstrainedBox(

              constraints: const BoxConstraints(
                maxWidth: 600,
              ),


              child: Padding(

                padding: const EdgeInsets.symmetric(
                  vertical: 40, 
                ),

                child: Form(

                  key: _formKey,

                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      Text(
                        'Crea Account',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium,
                      ),

                      const SizedBox(height: 8),

                      Text(
                        "Crea il tuo account per monitorare l'ipertensione",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium,
                      ),

                      const SizedBox(height: 32),

                      TextFormField(

                        controller: _usernameController,

                        decoration: const InputDecoration(
                          labelText: 'Username',
                          prefixIcon: Icon(Icons.person),
                        ),

                        validator: (value) {

                          if (value == null || value.trim().isEmpty) {
                            return 'Username è un campo obbligatorio';
                          }

                          return null;

                        },

                      ),

                      const SizedBox(height: 16),

                      TextFormField(

                        controller: _emailController,

                        keyboardType: TextInputType.emailAddress,

                        decoration: const InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email),
                        ),

                        validator: (value) {

                          if (value == null || value.trim().isEmpty) {
                            return 'Email è un campo obbligatorio';
                          }

                          return null;

                        },

                      ),

                      const SizedBox(height: 16),

                      TextFormField(

                        controller: _passwordController,

                        obscureText: true,

                        decoration: const InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                        ),

                        validator: (value) {

                          if (value == null || value.length < 6) {
                            return 'Minimo 6 caratteri';
                          }

                          return null;

                        },

                      ),

                      const SizedBox(height: 16),

                      TextFormField(

                        controller: _confirmPasswordController,

                        obscureText: true,

                        decoration: const InputDecoration(
                          labelText: 'Conferma password',
                          prefixIcon: Icon(Icons.lock_outline),
                        ),

                        validator: (value) {

                          if (value != _passwordController.text) {
                            return 'Passwords non corrispondenti';
                          }

                          return null;

                        },

                      ),

                      const SizedBox(height: 32),

                      Text(
                        "Come intendi usare l'applicazione?",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium,
                      ),

                      const SizedBox(height: 12),

                      RadioGroup<UserRole>(

                        groupValue: _selectedRole,

                        onChanged: (value) {

                          if (value != null) {

                            setState(() {

                              _selectedRole = value;

                            });

                          }

                        },

                        child: Column(

                          children: [

                            RadioListTile<UserRole>(

                              value: UserRole.patient, 

                              title: const Text(
                                'Paziente',
                              ), 

                              subtitle: const Text(
                                'Gestire i propri dati clinici',
                              ),

                            ), 

                            RadioListTile<UserRole>(

                              value: UserRole.user, 

                              title: const Text(
                                'User', 
                              ), 

                              subtitle: const Text(
                                'Gestire uno o più pazienti',
                              ),

                            ), 

                          ],

                        ),

                      ),

                      

                      const SizedBox(height: 32),

                      FilledButton(

                        onPressed: _register, 

                        child: const Text(
                          'Crea account',
                        ),

                      ),

                    ],

                  ),

                ),

              ),


            ),

          ),

        ),

      ),

    );

  }

}