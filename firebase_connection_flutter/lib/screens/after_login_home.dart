import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_connection_flutter/bloc/auth/auth_bloc.dart';
import 'package:firebase_connection_flutter/bloc/task/task_bloc.dart';
import 'package:firebase_connection_flutter/models/task.dart';
import 'package:firebase_connection_flutter/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginHome extends StatefulWidget {
  const LoginHome({super.key});

  @override
  State<LoginHome> createState() => _LoginHomeState();
}

class _LoginHomeState extends State<LoginHome> {
  final TextEditingController _taskInputController = TextEditingController();
  String uid = FirebaseAuth.instance.currentUser?.uid ?? '';
  void loadTasks() {
    context.read<TaskBloc>().add(LoadTasks(uid));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("User Page"),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
        actions: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/community");
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Icon(Icons.chat, color: Colors.blue),
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.read<AuthBloc>().add(AuthLogoutButtonPressed());
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Icon(Icons.logout),
                ),
              ),
            ],
          ),
        ],
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthInitial) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const HomePage(),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthSuccess) {
            uid = state.uid;
            loadTasks(); //load tasks when entered from authgate not from login/signup
          }
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return BlocBuilder<TaskBloc, TaskState>(
            builder: (context, state) {
              List<Task> tasks = [];

              if (state is TaskInitial) {
                loadTasks();
              }
              if (state is TaskLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is TaskLoaded) {
                tasks = state.tasks;
              }
              if (state is TaskFailure) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("failed to load the data .."),
                      IconButton(
                        onPressed: loadTasks,
                        icon: const Icon(Icons.refresh),
                      ),
                    ],
                  ),
                );
              }
              // ignore: prefer_is_empty
              if (tasks.length == 0) {
                return Center(child: const Text("No tasks available to show "));
              }
              return ListView.separated(
                shrinkWrap: true,
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return ListTile(
                    leading: Checkbox(
                      value: task.completed,
                      onChanged: (_) {
                        context.read<TaskBloc>().add(
                          TaskCompleted(task.id, task.completed),
                        );
                      },
                    ),
                    title: Text(task.title),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Confirmation'),
                              content: Text(
                                "Are you sure you want to delete this task ?",
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    context.read<TaskBloc>().add(
                                      TaskDeleted(task.id),
                                    );
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Add New Task'),
                content: TextField(
                  controller: _taskInputController,
                  decoration: InputDecoration(labelText: "Input task here "),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      context.read<TaskBloc>().add(
                        NewTaskAdded(
                          name: _taskInputController.text.trim(),
                          uid: uid,
                        ),
                      );
                      _taskInputController.clear();
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
