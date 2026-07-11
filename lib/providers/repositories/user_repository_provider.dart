import 'package:flutter_riverpod/flutter_riverpod.dart'; 

import 'package:flutter_hypertension_monitor/data/repositories/user_repository.dart';

final userRepositoryProvider =
        Provider<UserRepository>((ref) {

    return UserRepository();

});