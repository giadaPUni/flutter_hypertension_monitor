import 'package:flutter_riverpod/flutter_riverpod.dart'; 

import 'app_user.dart'; 

class CurrentUserNotifier extends Notifier<AppUser?>{

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

}

final currentUserProvider = 
    NotifierProvider<CurrentUserNotifier, AppUser?>(
        CurrentUserNotifier.new, 
    ); 