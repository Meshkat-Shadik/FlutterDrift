import 'package:drift_sqlite_test/data/database.dart';
import 'package:drift_sqlite_test/data/daos/task_dao.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dbProvider = Provider((ref) => TasksDao(AppDatabase()));
