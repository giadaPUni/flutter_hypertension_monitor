import 'package:flutter/material.dart';

import 'package:flutter_hypertension_monitor/core/user/user_role.dart';

/// Registration page.
///
/// Allows the user to:
/// - create an application account;
/// - choose how the application will be used;
/// - register either as a patient or as a user managing patients.
class RegisterPage extends StatefulWidget {
  const RegisterPage({
    super.key,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

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

    debugPrint('Username: $username'); 
    debugPrint('Email: $email'); 
    debugPrint('role: $role');


    ScaffoldMessenger.of(context).showSnackBar(

      const SnackBar(

        content: Text(
          'Registration validated',
        ),

      ),

    );

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'Create account',
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
                        'Create Account',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium,
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Create your Hypertension Monitor account.',
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
                            return 'Username is required';
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
                            return 'Email is required';
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
                            return 'Minimum 6 characters';
                          }

                          return null;

                        },

                      ),

                      const SizedBox(height: 16),

                      TextFormField(

                        controller: _confirmPasswordController,

                        obscureText: true,

                        decoration: const InputDecoration(
                          labelText: 'Confirm password',
                          prefixIcon: Icon(Icons.lock_outline),
                        ),

                        validator: (value) {

                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }

                          return null;

                        },

                      ),

                      const SizedBox(height: 32),

                      Text(
                        'How will you use the application?',
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
                                'Patient',
                              ), 

                              subtitle: const Text(
                                'Manage you own health data',
                              ),

                            ), 

                            RadioListTile<UserRole>(

                              value: UserRole.user, 

                              title: const Text(
                                'User', 
                              ), 

                              subtitle: const Text(
                                'Manage one or more patients',
                              ),

                            ), 

                          ],

                        ),

                      ),

                      

                      const SizedBox(height: 32),

                      FilledButton(

                        onPressed: _register, 

                        child: const Text(
                          'Create account',
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