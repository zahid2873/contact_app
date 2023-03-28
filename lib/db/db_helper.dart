
import 'package:contactapp/models/contact_model.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class DbHelper{
static  String _createTableContact = '''CREATE TABLE $tblContact(
  $tblContactColId INTEGER PRIMARY KEY AUTOINCREMENT,
  $tblContactColName TEXT, 
  $tblContactColMobile TEXT, 
  $tblContactColEmail TEXT, 
  $tblContactColDesignation TEXT, 
  $tblContactColCompany TEXT, 
  $tblContactColAddress TEXT, 
  $tblContactColWebsite TEXT, 
  $tblContactColFavorite INTEGER)''';

static Future<Database> _open() async {
  final rootPath = await getDatabasesPath();
  final dbPath = p.join('contact.db');
  return openDatabase(dbPath,version: 1, onCreate: (db,version){
    db.execute(_createTableContact);
  });
}

static Future<int> insertConatct(ContactModel contactModel) async{
  final db = await _open();
  return db.insert(tblContact, contactModel.toMap());
}
static Future<int> updateContact(int id, Map<String, dynamic>map)async{
  final db = await _open();
  return db.update(tblContact, map, where: '$tblContactColId = ?', whereArgs: [id]);
}

static Future<List<ContactModel>> getAllContact()async{
  final db = await _open();
  final List<Map<String, dynamic>> mapList = await db.query(tblContact);
  return List.generate(mapList.length, (index) => ContactModel.fromMap(mapList[index]));
}

static Future<ContactModel> getContactById(int id)async{
  final db = await _open();
  final List<Map<String,dynamic>> mapList = await db.query(tblContact,where: '$tblContactColId=?',whereArgs: [id]);
  return ContactModel.fromMap(mapList.first);
}

static Future<List<ContactModel>> getFavoriteContact()async{
  final db = await _open();
  final List<Map<String,dynamic>> maplist = await db.query(tblContact,where: '$tblContactColFavorite=?',whereArgs: [1]);
  return List.generate(maplist.length, (index)=>ContactModel.fromMap(maplist[index]));
}

static Future<int>  deleteContact(int id) async {
  final db = await _open();
  return db.delete(tblContact,where: '$tblContactColId=?',whereArgs: [id]);
}

}