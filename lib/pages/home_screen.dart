import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:simple_note/extension/date_formater.dart';
import 'package:simple_note/models/note.dart';
import 'package:simple_note/services/database_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseService dbService = DatabaseService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Simple Note"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).pushNamed('add-note');
        },
        child: Icon(
          Icons.post_add_rounded,
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box(DatabaseService.boxName).listenable(), 
        builder: (context, box, _) {
          if (box.isEmpty) {
            return Center(
              child: Text("Tidak ada data"),
            );
          } else {
            return ListView.separated(
              itemBuilder: (context, index) {
                Note tempNote = box.getAt(index);
                return Dismissible(
                  key: Key(tempNote.key.toString()),
                  onDismissed: (_) {
                    dbservice.deleteNote(tempNote).then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(content: Text("Data ${tempNote.title} telah dihapus"))
                    })
                  },
                  child: NoteCard(
                    note: tempNote,
                    ),
                );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 8,
              );
            }, 
            itemCount: box.length,
            );
          }
        },
        ),
    );
  }
}

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.note,
  });

  final Note note;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 3,
        ),
      child: ListTile(
        onTap: () {},
        title: Text(note.title),
        subtitle: Text(note.description),
        trailing: Text('Dibuat pada:\n ${note.createdAt.toSunda()}'),
        ),
    );
  }
}