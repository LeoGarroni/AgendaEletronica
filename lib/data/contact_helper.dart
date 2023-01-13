// ignore_for_file: public_member_api_docs, sort_constructors_first, depend_on_referenced_packages
// ignore_for_file: prefer_const_declarations

import 'dart:math';

import 'package:get/get.dart';
import 'package:group_software/controllers/contact_controller.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/contact_model.dart';

final String contactTable = "contactTable";
final String idColumn = "idColumn";
final String firstNameColumn = "firstNameColumn";
final String lastNameColumn = "lastNameColumn";
final String cpfColumn = "cpfColumn";
final String emailColumn = "emailColumn";
final String imgColumn = "imgColumn";
final String residentialPhoneColumn = "residentialPhoneColumn";
final String workPhoneColumn = "workPhoneColumn";
final String cellPhoneColumn = "cellPhoneColumn";

class ContactHelper {

  static final ContactHelper _instance = ContactHelper.internal();

  factory ContactHelper() => _instance;

  ContactHelper.internal();

  Database? _db;

  ContactController? contactController;

  bool firstRun = false;

  Future<Database?> get db async {
    firstRun = await IsFirstRun.isFirstRun();
    if(_db != null) {
      return _db;
    } else {
      _db = await initDb();
      if(firstRun){
       await getFirstContacts();
      }
    return _db;
    }
  }

  Future<void> getFirstContacts() async{
    Get.put(ContactController());
    contactController = Get.find<ContactController>();
    await contactController?.getContacts();
    for (var item in contactController!.contacts!) {
    await saveContact(item);
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "contacts.db");

    return await openDatabase(path, version: 1, onCreate: (Database db, int newerVersion) async {
      await db.execute("CREATE TABLE $contactTable($idColumn INTEGER PRIMARY KEY, $firstNameColumn TEXT, $lastNameColumn TEXT, $cpfColumn TEXT, $emailColumn TEXT, $imgColumn, $residentialPhoneColumn TEXT, $workPhoneColumn TEXT, $cellPhoneColumn TEXT )");
    });
  }

  Future<ContactModel> saveContact(ContactModel contact) async {
    Database? dbContact = await db;
    var rng = Random();
    contact.id = rng.nextInt(10000) + 10;
    contact.id = await dbContact!.insert(contactTable, contact.toMap());
    return contact;
  }


  Future<int> deleteContact(int id) async {
    Database? dbContact = await db;
    return await dbContact!.delete(contactTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> updateContact(ContactModel contact) async {
    Database? dbContact = await db;
    return await dbContact!.update(contactTable, contact.toMap(), where: "$idColumn = ?", whereArgs: [contact.id]);
  }

  Future<List> getAllContacts() async {
    Database? dbContact = await db;
    List listMap = await dbContact!.rawQuery("SELECT * FROM $contactTable");
    List<ContactModel> listContact = [];
    for(Map m in listMap) {
      listContact.add(ContactModel.fromMap(m));
    }
    return listContact;
  }

}
