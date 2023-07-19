
import 'package:hive/hive.dart';
part 'note.g.dart';

@HiveType(typeId: 0)
class NoteModel {

  @HiveField(0)
  String? title;

  @HiveField(1)
  String? note;

  NoteModel(this.title, this.note);
}
