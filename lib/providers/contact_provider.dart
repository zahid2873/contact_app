import 'package:contactapp/db/db_helper.dart';
import 'package:flutter/material.dart';

import '../models/contact_model.dart';

class ContactProvider extends ChangeNotifier{
  List<ContactModel> contactList=[];


  Future<int> insertConatct (ContactModel contactModel)async{
    final rowId = await DbHelper.insertConatct(contactModel);
     contactModel.id = rowId;
     contactList.add(contactModel);
     notifyListeners();
    return rowId;
  }

  Future<int> contactUpdate(int rowId, String column, dynamic value) async{
    final map = {column :value};
    final id = await DbHelper.updateContact(rowId, map);
    // final contactModel = contactList.firstWhere((element) => element.id==rowId);
    // contactModel.favorite = !contactModel.favorite;
    // final index = contactList.indexOf(contactModel);
    // contactList[index] = contactModel;
    // notifyListeners();
    return id;
  }

  getAllContact()async{
    contactList = await DbHelper.getAllContact();
    notifyListeners();

  }

  Future<ContactModel> getContactById(int id){
    return DbHelper.getContactById(id);
  }

  void deleteConatct(int id)async{
    final rowId = DbHelper.deleteContact(id);
    contactList.removeWhere((element) => element.id==id);
    notifyListeners();
  }

}