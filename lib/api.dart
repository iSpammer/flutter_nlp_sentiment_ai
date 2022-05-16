/// a local `Hive` database instance.
///
/// To use, import `package:diary/api.dart`.
library api;

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:diary/models.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:leitmotif/leitmotif.dart';

part 'api/all_data_provider.dart';
part 'api/app_api.dart';
part 'api/app_settings_provider.dart';
part 'api/database_state_validator.dart';
part 'api/default_data.dart';
part 'api/diary_entry_provider.dart';
part 'api/query_controller.dart';
part 'api/query_diary_entry_provider.dart';
part 'api/user_created_color_provider.dart';
part 'api/user_data_provider.dart';
