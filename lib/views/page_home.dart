import 'package:crud_sqlite_sqflite/data/db/database_helper.dart';
import 'package:crud_sqlite_sqflite/data/models/user.dart';
import 'package:crud_sqlite_sqflite/themes/app_theme.dart';
import 'package:flutter/material.dart';

class PageHome extends StatefulWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  int? selectedId;
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      home: _home(context),
    );
  }

  Widget _home(context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Simple CRUD | SQF LITE")),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: textController,
              cursorColor: Theme.of(context).accentColor,
              decoration: InputDecoration(
                labelText: 'Input Name',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(
              color: Colors.grey[250],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<User>>(
                future: DatabaseHelper.instance.getUsers(),
                builder:
                    (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: Text("Loading..."));
                  }
                  return snapshot.data!.isEmpty
                      ? Center(child: Text("No user data in list."))
                      : ListView(
                          padding: EdgeInsets.all(16.0),
                          children: snapshot.data!.map((user) {
                            return Center(
                              child: Card(
                                color: selectedId == user.id
                                    ? Colors.white70
                                    : Colors.white,
                                elevation: 3.0,
                                child: ListTile(
                                  title: Text(user.name),
                                  onTap: () {
                                    setState(() {
                                      if (selectedId == user.id) {
                                        textController.text = "";
                                        selectedId = null;
                                      } else {
                                        textController.text = user.name;
                                        selectedId = user.id;
                                      }
                                    });
                                  },
                                  onLongPress: () {
                                    setState(() {
                                      selectedId = null;
                                      textController.clear();
                                      DatabaseHelper.instance
                                          .remove(user.id ?? 0);
                                    });
                                  },
                                ),
                              ),
                            );
                          }).toList(),
                        );
                }),
          )
        ],
      ),
      floatingActionButton: Theme(
        data: Theme.of(context).copyWith(splashColor: Colors.yellow),
        child: FloatingActionButton(
          onPressed: () async {
            selectedId != null
                ? await DatabaseHelper.instance.update(
                    User(id: selectedId, name: textController.text),
                  )
                : await DatabaseHelper.instance.add(
                    User(name: textController.text),
                  );
            setState(() {
              selectedId = null;
              textController.clear();
            });
          },
          child: const Icon(Icons.save, color: Colors.white),
        ),
      ),
    );
  }
}
