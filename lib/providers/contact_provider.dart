import 'package:flutter/foundation.dart';
import 'package:visiting_card/db/dbhelper.dart';
import 'package:visiting_card/models/contact_model.dart';

class ContactProvider extends ChangeNotifier{
  List<ContactModel> contactlist=[];
  final db=Dbhelper();

  Future<int> insertContact(ContactModel contactModel) async{
    final rowId= await db.insertContact(contactModel);
    contactModel.id=rowId;
    contactlist.add(contactModel);
    notifyListeners();
    return rowId;
  }

  Future<void> getAllContacts() async{
    contactlist= await db.getAllContacts();
    notifyListeners();
  }

  Future<int> deleteContact(int id)
  {
    return db.deleteContact(id);
  }
}