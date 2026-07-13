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
          'No user logged',
        ),
      );
    
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min, 

        children: [

          Text(
            user.name, 
          ), 

          Text(
            user.email, 
          ), 

          Text(
            user.role.name, 
          ), 

        ], 
      ), 
    ); 


  }
}