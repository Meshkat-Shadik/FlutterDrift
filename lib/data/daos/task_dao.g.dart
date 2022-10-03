// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_dao.dart';

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$TasksDaoMixin on DatabaseAccessor<AppDatabase> {
  $TasksTable get tasks => attachedDatabase.tasks;
  Selectable<Task> completedTasksGenerated() {
    return customSelect(
        'SELECT * FROM tasks WHERE completed = 1 ORDER BY date DESC, name',
        variables: [],
        readsFrom: {
          tasks,
        }).asyncMap(tasks.mapFromRow);
  }
}
