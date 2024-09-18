import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'package:visiting_card/models/contact_model.dart';
class Dbhelper{
  final String _createTableContact='''create table $tableContact(
  $tblContactColId integer primary key autoincrement,
  $tblContactColName text,
  $tblContactColMobile text,
  $tblContactColEmail text,
  $tblContactColAddress text,
  $tblContactColCompany text,
  $tblContactColDesignation text,
  $tblContactColWebsite text,
  $tblContactColImage text,
  $tblContactColFavourite integer)''';
  Future<Database> _open() async{
    final root = await getDatabasesPath();
    final dbpath= p.join(root,'contact.db');
    return openDatabase(dbpath, version: 1, onCreate: (db, version){
      db.execute(_createTableContact);
    },);
  }

  Future<int> insertContact(ContactModel contactModel) async{
    final db= await _open();
    return db.insert(tableContact, contactModel.toMap());
  }

  Future<List<ContactModel>> getAllContacts() async{
    final db= await _open();
    final mapList =await db.query(tableContact);
    return List.generate(mapList.length, (index) => ContactModel.formMap(mapList[index]));
  }

  Future<int> deleteContact(int id) async{
    final db= await _open();
    return db.delete(tableContact, where: '$tblContactColId= ?', whereArgs: [id]);
  }

  Future<int> updateContactField(int id, Map<String, dynamic>map) async{
    final db = await _open();
    return db.update(tableContact, map, where: '$tblContactColId= ?', whereArgs: [id]);
  }
}