import 'package:crud_sqlite_sqflite/cubit/user_cubit.dart';
import 'package:crud_sqlite_sqflite/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';

class PageHome extends StatefulWidget {
  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  int? selectedId;
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserCubit>(context).getUsers();
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("CRUD | SQF LITE | CUBIT"))),
      body: _userList(),
      floatingActionButton: _floatingButton(context),
    );
  }

  Widget _userList() {
    List<User> users = [];
    BlocProvider.of<UserCubit>(context).getUsers();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextFormField(
            controller: textController,
            cursorColor: Theme.of(context).accentColor,
            decoration: InputDecoration(
                labelText: 'Input Name', border: OutlineInputBorder()),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Divider(color: Colors.grey[250]),
        ),
        BlocConsumer<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return _loadingIndicator();
            } else if (state is UserLoaded) {
              users = state.users;
            }
            return Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return _user(users[index], context);
                  },
                  separatorBuilder: (context, index) {
                    return Container();
                  },
                  itemCount: users.length),
            );
          },
          listener: (context, state) {
            if (state is UserError) {
              Logger().e(state.error);
              Fluttertoast.showToast(
                msg: state.error,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.red,
                fontSize: 16.0,
                webPosition: "center",
              );
            }
          },
        )
      ],
    );
  }

  Widget _floatingButton(context) {
    return Theme(
      data: Theme.of(context).copyWith(splashColor: Colors.yellow),
      child: FloatingActionButton(
        onPressed: () {
          final message = textController.text;
          var user = User(id: selectedId, name: message);
          selectedId == null
              ? BlocProvider.of<UserCubit>(context).addUser(user)
              : BlocProvider.of<UserCubit>(context).updateUser(user);
          selectedId = null;
          textController.clear();
        },
        child: const Icon(Icons.save, color: Colors.white),
      ),
    );
  }

  Widget _loadingIndicator() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _user(User user, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      child: Card(
        child: InkWell(
          onTap: () {
            if (selectedId == user.id) {
              textController.text = "";
              selectedId = null;
            } else {
              textController.text = user.name;
              selectedId = user.id;
            }
          },
          onLongPress: () {
            selectedId = null;
            textController.clear();
            BlocProvider.of<UserCubit>(context).removeUser(user);
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("${user.id} ${user.name}"),
          ),
        ),
      ),
    );
  }
}
