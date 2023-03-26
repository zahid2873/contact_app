import 'package:contactapp/providers/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/contact_model.dart';

class ContactDetailsPage extends StatefulWidget {
  static const String routeName = '/details';
  const ContactDetailsPage({Key? key}) : super(key: key);

  @override
  State<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
  late ContactModel contactModel;
  late ContactProvider contactProvider;
  bool isFirst = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if(isFirst){
      contactProvider = Provider.of<ContactProvider>(context);
      contactModel = ModalRoute.of(context)!.settings.arguments as ContactModel;
      isFirst = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contactModel.name),
      ),
      body: FutureBuilder(
        future: contactProvider.getContactById(contactModel.id),
        builder: (context, snapshot) {
           if(snapshot.hasData){
             final contact = snapshot.data!;
             return ListView(
              children: [

              ],
            );
          }
           if(snapshot.hasError){
             return const Center(child: Text("Failed to fetch data"),);
           }
           return const Center(child: CircularProgressIndicator(),);

        },
      ),
    );
  }
}
