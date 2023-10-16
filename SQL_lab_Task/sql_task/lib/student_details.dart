import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sql_task/dataBaseHelper.dart';
import 'package:sql_task/notes.dart';

class Detail extends StatefulWidget {
  const Detail({super.key});

  @override
  State<Detail> createState() => DetailState();
}

class DetailState extends State<Detail> {
  TextEditingController rollno = TextEditingController();
  TextEditingController name = TextEditingController();
  int selectedId = -1;
  List<Notes> notes = [];

  _loadnotes() async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    final notelist = await databaseHelper.queryAll();
    setState(() {
      notes = notelist;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadnotes();
  }

  void update2() async {
    DatabaseHelper dbHelper = DatabaseHelper();
    Notes note = Notes(id: selectedId, rollno: rollno.text, name: name.text);

    if (selectedId == -1) {
      await dbHelper.insert(note);
    } else {
      await dbHelper.update(note);
    }
    Navigator.of(context).pop(note);
  }

  void search(String query) async {
    if (query.isEmpty) {
      _loadnotes();
    } else {
      DatabaseHelper dbHelper = DatabaseHelper();
      final searchResults = await dbHelper.searchStudents(query);
      setState(() {
        notes = searchResults;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text('List Of Students'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                search(value);
              },
              decoration: const InputDecoration(
                hintText: "Search Students Here!...",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 400,
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: Colors.black,
                  width: 2.0,
                ),
              ),
              child: Expanded(
                child: ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    final note = notes[index];
                    return ListTile(
                      title: Text(note.rollno),
                      subtitle: Text(note.name),
                      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            DatabaseHelper dbHelper = DatabaseHelper();
                            await dbHelper.delete(note.id!);
                            _loadnotes();
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            update2();
                          },
                        ),
                      ]),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
