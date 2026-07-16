import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; 

import 'package:flutter_hypertension_monitor/core/user/current_user_provider.dart'; 

class ProfilePage extends ConsumerWidget {

  const ProfilePage({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref, 
  ) {

    final user = ref.watch(currentUserProvider); 

    if (user == null) {

      return const Center(
        child: Text(
          'Nessun utente autenticato',
        ),
      );
    
    }

    return SingleChildScrollView(

      padding: const EdgeInsets.all(24), 

      child: Center(

        child: ConstrainedBox(

          constraints: const BoxConstraints(
            maxWidth: 600, 
          ), 

          child: Column(

            children: [

              CircleAvatar(

                radius: 48, 

                child: Text(

                  user.name.characters.first.toUpperCase(), 

                  style: const TextStyle(
                    fontSize: 32, 
                    fontWeight: FontWeight.bold,
                  ), 

                ), 

              ), 

              const SizedBox(height: 16), 

              Text(

                user.name, 

                style: Theme.of(context)
                  .textTheme
                  .headlineSmall, 

              ), 

              const SizedBox(height: 4), 

              Text(

                'Account personale', 

                style: Theme.of(context)
                  .textTheme
                  .bodyMedium, 

              ), 

              const SizedBox(height: 32), 

              _ProfileTile(

                icon: Icons.person_outline, 

                title: 'Username', 

                value: user.name, 

              ), 

              const SizedBox(height: 16), 

              _ProfileTile(

                icon: Icons.email_outlined, 

                title: 'Email', 

                value: user.email, 

              ), 

              const SizedBox(height: 16), 

              _ProfileTile(
                icon: Icons.badge_outlined, 

                title: 'Tipo account', 

                value: user.isPatient
                  ? 'Paziente \nMonitoraggio personale'
                  : 'Utente \nGestione multi-paziente'
              ), 

            ], 

          ), 

        ), 

      ), 

    ); 

  }

}

class _ProfileTile extends StatelessWidget {

  const _ProfileTile({

    required this.icon, 

    required this.title, 

    required this.value,

  });

  final IconData icon; 

  final String title; 

  final String value; 

  @override
  Widget build(BuildContext context) {

    return Card(

      child: ListTile(

        leading: Icon(icon), 

        title: Text(title), 

        subtitle: Text(value),
      ), 
    ); 
  }
}