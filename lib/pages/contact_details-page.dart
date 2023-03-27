import 'dart:io';

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
                  leading: IconButton(onPressed: (){
                    showSingleTextInputDialog(
                        context: context,
                        title: "Mobile",
                        inputType: TextInputType.phone,
                        onUpate: (value){
                          contactProvider.contactUpdate(contact.id, tblContactColMobile, value)
                              .then((value) => setState((){}));
                        });
                  },icon:Icon(Icons.edit)),
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
                  leading: IconButton(onPressed: (){
                    showSingleTextInputDialog(
                        context: context,
                        title: "Email",
                        inputType: TextInputType.emailAddress,
                        onUpate: (value){
                          contactProvider.contactUpdate(contact.id, tblContactColEmail, value)
                              .then((value) => setState((){}));
                        });
                  },icon:Icon(Icons.edit)),
                  title: Text(contact.email.isEmpty?"Email not set yet": contact.email),
                  trailing: IconButton(onPressed: (){
                    if(contact.email.isEmpty){
                      showMsg(context, "Please first add email");
                    }else{
                    _sendEmail(contact.email);
                    }
                  },icon: Icon(Icons.email),),

                ),
                ListTile(
                  leading: IconButton(onPressed: (){
                    showSingleTextInputDialog(
                        context: context,
                        title: "Adreess",
                        inputType: TextInputType.text,
                        onUpate: (value){
                          contactProvider.contactUpdate(contact.id, tblContactColAddress, value)
                              .then((value) => setState((){}));
                        });
                  },icon:Icon(Icons.edit)),
                  title: Text(contact.address.isEmpty?"Address not set yet": contact.address),
                  trailing: IconButton(onPressed: (){
                    if(contact.address.isEmpty){
                      showMsg(context, "Please first add address");
                    }else{
                      _showAddressOnMap(contact.address);
                    }
                  },icon: Icon(Icons.location_on),),

                ),
                ListTile(
                  leading: IconButton(onPressed: (){
                    showSingleTextInputDialog(
                        context: context,
                        title: "Website",
                        inputType: TextInputType.text,
                        onUpate: (value){
                          contactProvider.contactUpdate(contact.id, tblContactColWebsite, value)
                              .then((value) => setState((){}));
                        });
                  },icon:Icon(Icons.edit)),
                  title: Text(contact.website.isEmpty?"Website not set yet": contact.website),
                  trailing: IconButton(onPressed: (){
                    if(contact.website.isEmpty){
                      showMsg(context, "Please first add website");
                    }else{
                      _showSiteOnBrowser(contact.website);
                    }
                  },icon: Icon(Icons.web),),

                ),
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

   _sendEmail(String email) async{
    final url = 'mailTo:$email';
    if(await canLaunchUrlString(url)){
     await launchUrlString(url);
     }else{
     showMsg(context, "Could not perform this operation");
     }
   }

   _showAddressOnMap(String address) async {
    String url = "";
    if (Platform.isAndroid){
      url = "geo:0,0?q=$address";

    }else{
      url = "http://maps.apple.com/?q=$address";

    }
    if(await canLaunchUrlString(url)){
     await launchUrlString(url);
     }else{
     showMsg(context, "Could not perform this operation");
     }

   }

   _showSiteOnBrowser(String website) async {
     final url = 'https://$website';
     if(await canLaunchUrlString(url)){
     await launchUrlString(url);
     }else{
     showMsg(context, "Could not perform this operation");
     }
   }
}
