import 'package:contactapp/db/db_helper.dart';
import 'package:contactapp/models/contact_model.dart';
import 'package:contactapp/providers/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactFormPage extends StatefulWidget {
  static const String routeName = '/form_page';
  const ContactFormPage({Key? key}) : super(key: key);

  @override
  State<ContactFormPage> createState() => _ContactFormPageState();
}

class _ContactFormPageState extends State<ContactFormPage> {
  final _nameContoller = TextEditingController();
  final _designationContoller = TextEditingController();
  final _companyContoller = TextEditingController();
  final _addressContoller = TextEditingController();
  final _emailContoller = TextEditingController();
  final _mobileContoller = TextEditingController();
  final _webContoller = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Contact"),

        actions: [
          IconButton(onPressed: (){_save();}, icon: Icon(Icons.save))
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameContoller,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                labelText:  "Contact Name",
                filled: true,
              ),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "This field must not be empty";
                }
                if(value.length>30){
                  return "Contact name should not be 30 chars long";
                }
                return null;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: _mobileContoller,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.call),
                labelText: "Mobile Number",
                filled: true
              ),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "This field must not be empty";
                }
                return null;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _emailContoller,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: "Email Address (Optional)",
                  filled: true
              ),
            ),
            TextFormField(
              controller: _designationContoller,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                labelText: "Designation (Optional)",
                filled: true,
              ),
              validator: (value){
                return null;
              },
            ),
            TextFormField(
              controller: _companyContoller,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                labelText: "Company Name (Optional)",
                filled: true,
              ),
              validator: (value){
                return null;
              },
            ),
            TextFormField(
              controller: _addressContoller,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.home_sharp),
                labelText: "Address (Optional)",
                filled: true
              ),
            ),
              TextFormField(
              controller: _webContoller,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.web),
                labelText: "Website (Optional)",
                filled: true,
              ),
            ),
          ],
        ),
      ),
    );
  }


  @override
  void dispose() {
    // TODO: implement dispose
    _nameContoller.dispose();
    _designationContoller.dispose();
    _companyContoller.dispose();
    _addressContoller.dispose();
    _emailContoller.dispose();
    _mobileContoller.dispose();
    _webContoller.dispose();
    super.dispose();
  }

  void _save() {
    if(_formKey.currentState!.validate()){
      //save data to database
      final contactModel = ContactModel(
        name: _nameContoller.text,
        mobile: _mobileContoller.text,
        email: _emailContoller.text,
        designation: _designationContoller.text,
        company: _companyContoller.text,
        address: _addressContoller.text,
        website: _webContoller.text

      );
      Provider.of<ContactProvider>(context,listen: false).insertConatct(contactModel)
          .then((value) => Navigator.pop(context));
      print(contactModel);
    }

  }

}
