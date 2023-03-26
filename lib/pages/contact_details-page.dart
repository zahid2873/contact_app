import 'package:contactapp/providers/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../models/contact_model.dart';
import '../utils/helper_function.dart';

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
                Image.asset("images/man-person-icon.png",height: 200,width: 200,),
                ListTile(
                  leading: IconButton(onPressed: (){},icon:Icon(Icons.edit)),
                  title: Text(contact.mobile),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(onPressed: (){
                        _callContact(contact.mobile);
                      }, icon: Icon(Icons.call)),
                      IconButton(onPressed: (){
                        _smsContact(contact.mobile);
                      }, icon: Icon(Icons.message)),
                    ],
                  ),
                ),
                ListTile(
                  leading: IconButton(onPressed: (){},icon:Icon(Icons.edit)),
                  title: Text(contact.email.isEmpty?"Email not set yet": contact.email),
                  trailing: IconButton(onPressed: (){
                    if(contact.email.isEmpty){
                      showMsg(context, "Please first add email");
                    }else{
                    _sendEmail(contact.email);
                    }
                  },icon: Icon(Icons.email),),

                )
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

  _callContact(String mobile) async {
    final url = 'tel:$mobile';
    if (await canLaunchUrlString(url)){
      await launchUrlString(url);
    }else{
      showMsg(context,"Could not perform this operation");

    }
  }

   _smsContact(String mobile) async{
    final url = 'sms:$mobile';
    if(await canLaunchUrlString(url)){
      await launchUrlString(url);
    }else{
      showMsg(context, "Could not perform this operation");
    }
   }

   _sendEmail(String email) {}
}
