import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_hypertension_monitor/features/auth/auth_service.dart';
import 'package:flutter_hypertension_monitor/data/repositories/user_repository_provider.dart';


/*
 * Connection between the service and Riverpod system
*/

final authServiceProvider = Provider<AuthService>(

    (ref) {

        final userRepository = ref.read(
            userRepositoryProvider, 
        ); 

        return AuthService(
            userRepository: userRepository,
        ); 
    }, 

); 