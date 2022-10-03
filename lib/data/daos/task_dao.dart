import 'package:drift/drift.dart';
import 'package:drift_sqlite_test/data/database.dart';
import 'package:drift_sqlite_test/data/entity/task_entity_table.dart';

part 'task_dao.g.dart';

@DriftAccessor(
  tables: [Tasks],
  queries: {
    'completedTasksGenerated':
        'SELECT * FROM tasks WHERE completed = 1 ORDER BY date DESC,name',
  }, //auto generated queries
)
class TasksDao extends DatabaseAccessor<AppDatabase> with _$TasksDaoMixin {
  TasksDao(AppDatabase db) : super(db);

  Future<List<Task>> getAllTasks() => select(tasks).get();
  Stream<List<Task>> watchAllTasks() {
    return (select(tasks)
          ..orderBy([
            //primary sorting by date
            (t) => OrderingTerm(
                  mode: OrderingMode.desc,
                  expression: t.date,
                ),
            //secondary sorting by alphabetical order
            (t) => OrderingTerm(expression: t.name),
          ]))
        .watch();
  }

  Stream<List<Task>> watchCompletedTasks() {
    return (select(tasks)
          ..where((t) => t.completed.equals(true))
          ..orderBy([
            (t) => OrderingTerm(
                  mode: OrderingMode.desc,
                  expression: t.date,
                ),
            (t) => OrderingTerm(expression: t.name),
          ]))
        .watch();
  }

  Stream<List<Task>> watchCompletedTasksCustom() {
    return customSelect(
      'SELECT * FROM tasks WHERE completed = 1 ORDER BY date DESC,name',
      readsFrom: {tasks},
    ).watch().map((rows) {
      //fromJson ekhane automatically int hocche, jodio seta bool type.
      // So, we have to convert it to bool type. (seta task_dao.g.dart file e kora hoise)
      return rows.map((row) => Task.fromJson(row.data)).toList();
    });
  }

  Future insertTask(TasksCompanion task) => into(tasks).insert(task);
  Future updateTask(TasksCompanion task) => update(tasks).replace(task);
  Future deleteTask(TasksCompanion task) => delete(tasks).delete(task);
}
