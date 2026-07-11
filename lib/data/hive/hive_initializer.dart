import 'package:hive_ce_flutter/hive_flutter.dart';

class HiveInitializer {

    static Future<void> initialize() async {

        await Hive.initFlutter(); 

        await _openBoxes(); 

    }

    static Future<void> _openBoxes() async {
        await Hive.openBox('settings');
    }

}