import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:memo_notes/models/note.dart';
import 'package:memo_notes/screens/add_notes_screen.dart';
import 'package:memo_notes/widgets/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<NoteModel> notesList = [];
  Box<NoteModel>? notesBox;

  @override
  void initState() {
    notesBox = Hive.box<NoteModel>('notes');
    getDataFromDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Home Screen'),
        centerTitle: true,
      ),
      drawer: const CustomDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNotesScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: notesList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                tileColor: Colors.yellow,
                title: Text('${notesList[index].title}'),
                subtitle: Text('${notesList[index].note}'),
                trailing: IconButton(
                  onPressed: () {
                    deleteNote(index);
                  },
                  icon: Icon(Icons.delete),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future getDataFromDatabase() async {
    await Hive.openBox<NoteModel>('notes');

    notesList = notesBox!.values.toList().cast<NoteModel>();
    setState(() {});

    print('...................${notesList.length}');
  }

  void deleteNote(int index) {
    notesList.removeAt(index);
    notesBox!.deleteAt(index);
    setState(() {});
  }
}
