import 'package:contactapp/db/db_helper.dart';
import 'package:flutter/material.dart';

import '../models/contact_model.dart';

class ContactProvider extends ChangeNotifier{
  List<ContactModel> contactList=[];

  getAllContact()async{
    contactList = await DbHelper.getAllContact();
    notifyListeners();

  }
}