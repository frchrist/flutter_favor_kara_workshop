


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final favorProvider = FutureProvider<List<dynamic>>((ref)  async{
   var appFavor = Hive.box("app_data");
   List<dynamic> favors = [];
    favors = appFavor.get("favors", defaultValue: []);
    return favors;
});