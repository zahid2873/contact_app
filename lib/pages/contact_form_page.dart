import 'package:contactapp/db/db_helper.dart';
import 'package:contactapp/models/contact_model.dart';
import 'package:contactapp/pages/home_pages.dart';
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
  final _nameController = TextEditingController();
  final _designationController = TextEditingController();
  final _companyController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _webController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    final contact = ModalRoute.of(context)!.settings.arguments as ContactModel;
    _nameController.text = contact.name;
    _designationController.text = contact.designation;
    _companyController.text = contact.company;
    _mobileController.text = contact.mobile;
    _emailController.text = contact.email;
    _addressController.text = contact.address;
    _webController.text = contact.website;
    super.didChangeDependencies();
  }


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
              controller: _nameController,
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
              controller: _mobileController,
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
              controller: _emailController,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: "Email Address (Optional)",
                  filled: true
              ),
            ),
            TextFormField(
              controller: _designationController,
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
              controller: _companyController,
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
              controller: _addressController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.home_sharp),
                labelText: "Address (Optional)",
                filled: true
              ),
            ),
              TextFormField(
              controller: _webController,
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
    _nameController.dispose();
    _designationController.dispose();
    _companyController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _webController.dispose();
    super.dispose();
  }

  void _save() {
    if(_formKey.currentState!.validate()){
      //save data to database
      final contactModel = ContactModel(
        name: _nameController.text,
        mobile: _mobileController.text,
        email: _emailController.text,
        designation: _designationController.text,
        company: _companyController.text,
        address: _addressController.text,
        website: _webController.text

      );
      Provider.of<ContactProvider>(context,listen: false).insertConatct(contactModel)
          .then((value) => Navigator.popUntil(context, ModalRoute.withName(HomePage.routeName)));
      print(contactModel);
    }

  }

}
