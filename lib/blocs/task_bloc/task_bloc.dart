import 'package:equatable/equatable.dart';
import 'package:todo_with_bloc/blocs/bloc_exports.dart';

import '../../models/task.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends HydratedBloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TaskState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<RemoveTask>(_onRemoveTask);
    on<FavoriteTask>(_onFavoriteTask);
    on<EditTask>(_onEditTask);
    on<RestoreTask>(_onRestoreTask);
    on<DeleteAllTask>(_onDeleteAllTask);
  }

  void _onAddTask(AddTask event, Emitter<TaskState> emit) {
    final state = this.state;
    emit(TaskState(
      pendingTasks: List.from(state.pendingTasks)..add(event.task),
      completedTasks: state.completedTasks,
      favoriteTasks: state.favoriteTasks,
      removedTasks: state.removedTasks,
    ));
  }

  void _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) {
    final state = this.state;
    final task = event.task;
    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;
    List<Task> favoriteTasks = state.favoriteTasks;

    if (task.isDone == false) {
      if (task.isFavorite == false) {
        pendingTasks = List.from(pendingTasks)..remove(task);
        completedTasks = List.from(completedTasks)
          ..insert(0, task.copyWith(isDone: true));
      } else {
        var indexTask = favoriteTasks.indexOf(task);
        pendingTasks = List.from(pendingTasks)..remove(task);
        completedTasks = List.from(completedTasks)
          ..insert(0, task.copyWith(isDone: true));
        favoriteTasks = List.from(favoriteTasks)
          ..remove(task)
          ..insert(indexTask, task.copyWith(isDone: true));
      }
    } else {
      if (task.isFavorite == false) {
        completedTasks = List.from(completedTasks)..remove(task);
        pendingTasks = List.from(pendingTasks)
          ..insert(0, task.copyWith(isDone: false));
      } else {
        var indexTask = favoriteTasks.indexOf(task);
        pendingTasks = List.from(pendingTasks)..remove(task);
        completedTasks = List.from(completedTasks)
          ..insert(0, task.copyWith(isDone: false));
        favoriteTasks = List.from(favoriteTasks)
          ..remove(task)
          ..insert(indexTask, task.copyWith(isDone: false));
      }
    }

    emit(TaskState(
      pendingTasks: pendingTasks,
      completedTasks: completedTasks,
      favoriteTasks: favoriteTasks,
      removedTasks: state.removedTasks,
    ));
  }

  void _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) {
    final state = this.state;
    emit(
      TaskState(
        pendingTasks: state.pendingTasks,
        completedTasks: state.completedTasks,
        favoriteTasks: state.favoriteTasks,
        removedTasks: List.from(state.removedTasks)..remove(event.task),
      ),
    );
  }

  void _onRemoveTask(RemoveTask event, Emitter<TaskState> emit) {
    final state = this.state;
    emit(
      TaskState(
        pendingTasks: List.from(state.pendingTasks)..remove(event.task),
        completedTasks: List.from(state.completedTasks)..remove(event.task),
        favoriteTasks: List.from(state.favoriteTasks)..remove(event.task),
        removedTasks: List.from(state.removedTasks)
          ..add(event.task.copyWith(isDeleted: true)),
      ),
    );
  }

  void _onFavoriteTask(FavoriteTask event, Emitter<TaskState> emit) {
    final state = this.state;
    List<Task> pendingTask = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;
    List<Task> favoriteTasks = state.favoriteTasks;

    if (event.task.isDone == false) {
      if (event.task.isFavorite == false) {
        var taskIndex = pendingTask.indexOf(event.task);
        pendingTask = List.from(pendingTask)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: true));
        favoriteTasks.insert(0, event.task.copyWith(isFavorite: true));
      } else {
        var taskIndex = pendingTask.indexOf(event.task);
        pendingTask = List.from(pendingTask)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: false));
        favoriteTasks.remove(event.task);
      }
    } else {
      if (event.task.isFavorite == false) {
        var taskIndex = completedTasks.indexOf(event.task);
        completedTasks = List.from(completedTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: true));
        favoriteTasks.insert(0, event.task.copyWith(isFavorite: true));
      } else {
        var taskIndex = completedTasks.indexOf(event.task);
        completedTasks = List.from(completedTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: false));
        favoriteTasks.remove(event.task);
      }
    }

    emit(
      TaskState(
        pendingTasks: pendingTask,
        completedTasks: completedTasks,
        favoriteTasks: favoriteTasks,
        removedTasks: state.removedTasks,
      ),
    );
  }

  void _onEditTask(EditTask event, Emitter<TaskState> emit) {
    final state = this.state;
    List<Task> favoriteTasks = state.favoriteTasks;
    if (event.oldTask.isFavorite == true) {
      favoriteTasks
        ..remove(event.oldTask)
        ..insert(0, event.newTask);
    }

    emit(TaskState(
      pendingTasks: List.from(state.pendingTasks)
        ..remove(event.oldTask)
        ..insert(0, event.newTask),
      completedTasks: state.completedTasks..remove(event.oldTask),
      favoriteTasks: favoriteTasks,
      removedTasks: state.removedTasks,
    ));
  }

  void _onRestoreTask(RestoreTask event, Emitter<TaskState> emit) {
    final state = this.state;
    emit(
      TaskState(
        removedTasks: List.from(state.removedTasks)..remove(event.task),
        pendingTasks: List.from(state.pendingTasks)
          ..insert(
            0,
            event.task.copyWith(
              isDeleted: false,
              isDone: false,
              isFavorite: false,
            ),
          ),
        completedTasks: state.completedTasks,
        favoriteTasks: state.favoriteTasks,
      ),
    );
  }

  void _onDeleteAllTask(DeleteAllTask event, Emitter<TaskState> emit) {
    final state = this.state;
    emit(
      TaskState(
        removedTasks: List.from(state.completedTasks)..clear(),
        pendingTasks: state.pendingTasks,
        completedTasks: state.completedTasks,
        favoriteTasks: state.favoriteTasks,
      ),
    );
  }

  @override
  TaskState? fromJson(Map<String, dynamic> json) {
    return TaskState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TaskState state) {
    return state.toMap();
  }
}
