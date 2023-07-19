import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:memo_notes/models/note.dart';

class AddNotesScreen extends StatefulWidget {
  const AddNotesScreen({super.key});

  @override
  State<AddNotesScreen> createState() => _AddNotesScreenState();
}

class _AddNotesScreenState extends State<AddNotesScreen> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Note'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40.0,
                ),
                TextFormField(
                  controller: titleController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '*please add title';
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: 'Add Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                TextFormField(
                  controller: notesController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '*please add note';
                    }
                  },
                  maxLines: 15,
                  decoration: const InputDecoration(
                    hintText: 'Add Note',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      saveDataToDatabase().then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Date Saved to database'),
                          ),
                        );
                        titleController.clear();
                        notesController.clear();
                        setState(() {});
                      });
                    }
                  },
                  child: Container(
                    height: 50.0,
                    width: 150.0,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Center(
                      child: Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future saveDataToDatabase() async {
    var notesBox = await Hive.openBox<NoteModel>('notes');
    NoteModel noteModel = NoteModel(
      titleController.text,
      notesController.text,
    );

    notesBox.add(noteModel);
  }
}
