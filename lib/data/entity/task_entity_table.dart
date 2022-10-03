import 'package:drift/drift.dart';

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  DateTimeColumn get date => dateTime().nullable()();
  BoolColumn get completed => boolean().withDefault(const Constant(false))();
}
