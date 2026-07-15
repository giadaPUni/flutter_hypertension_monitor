import 'package:flutter_riverpod/flutter_riverpod.dart'; 

import 'app_user.dart'; 

import 'package:flutter_hypertension_monitor/data/repositories/user_repository.dart';

class CurrentUserNotifier extends Notifier<AppUser?> {

    @override
    AppUser? build() {

        return null;

    }

    void login(
        AppUser user, 
    ) {

        state = user; 

    }

    void logout() {

        state = null; 

    }


    Future<void> updatePatientId(
        String patientId,
        UserRepository repository,
    ) async {


        if(state == null){

            return;

        }


        await repository.updatePatientId(
            state!.id,
            patientId,
        );


        state = AppUser(

            id: state!.id,

            name: state!.name,

            email: state!.email,

            role: state!.role,

            patientId: patientId,

        );

    } 

}

final currentUserProvider = 
    NotifierProvider<CurrentUserNotifier, AppUser?>(
        CurrentUserNotifier.new, 
    ); 