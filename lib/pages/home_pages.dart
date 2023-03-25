import 'package:contactapp/pages/contact_form_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/';
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    );
  }
}
