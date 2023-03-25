import 'package:contactapp/models/contact_model.dart';
import 'package:contactapp/pages/contact_form_page.dart';
import 'package:contactapp/providers/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/';
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<ContactProvider>(context,listen: false).getAllContact();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, ContactFormPage.routeName);
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Contact List"),
      ),
      body: Consumer<ContactProvider>(
        builder:(context,provider,child)=> ListView.builder(
          itemCount: provider.contactList.length,
            itemBuilder: (context,index){
            final contact = provider.contactList[index];
            return ListTile(
              title: Text("${contact.name}"),
              trailing: IconButton(
                onPressed: (){},
                icon: Icon(contact.favorite? Icons.favorite:Icons.favorite_border),
              )
            );},),
      ),
    );
  }
}
