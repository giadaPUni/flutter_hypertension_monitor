import 'package:hive_ce/hive.dart'; 

part 'user_role.g.dart';


@HiveType(typeId: 10)
enum UserRole {

    @HiveField(0)
    patient,


    @HiveField(1)
    user,

}