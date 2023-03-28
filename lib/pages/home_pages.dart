import 'package:contactapp/models/contact_model.dart';
import 'package:contactapp/pages/contact_details-page.dart';
import 'package:contactapp/pages/contact_form_page.dart';
import 'package:contactapp/providers/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  @override
  void didChangeDependencies() {
    Provider.of<ContactProvider>(context,listen: false).getAllContact();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, ContactFormPage.routeName);
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Contact List"),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        clipBehavior: Clip.antiAlias,
        elevation: 20,

        child: BottomNavigationBar(
          currentIndex: index,
          onTap: (value){
            setState(() {
              index=value;
            });
            _fetchData();
          },
          items: const[
            BottomNavigationBarItem(icon: Icon(Icons.contacts),label: "All Contacts"),
            BottomNavigationBarItem(icon: Icon(Icons.favorite),label: "Favourite"),
          ],
        ),
      ),

      body: Consumer<ContactProvider>(
        builder:(context,provider,child)=> ListView.builder(
          itemCount: provider.contactList.length,
            itemBuilder: (context,index){
            final contact = provider.contactList[index];
            return Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.all(8),
                child: const Icon(Icons.delete),
              ),
              confirmDismiss: showDeleteConfirmationDialog,
              onDismissed: (direction){
                provider.deleteConatct(contact.id);
              },
              child: ListTile(
                onTap: (){
                  Navigator.pushNamed(context, ContactDetailsPage.routeName, arguments: contact);
                },
                title: Text("${contact.name}"),
                trailing: IconButton(
                  onPressed: (){
                    final value = contact.favorite? 0:1;
                    provider.contactFavoriteUpdate(contact.id, tblContactColFavorite, value);
                  },
                  icon: Icon(contact.favorite? Icons.favorite:Icons.favorite_border,),
                )
              ),
            );},),
      ),
    );
  }
  Future <bool?> showDeleteConfirmationDialog(DismissDirection direction){
    return showDialog(context: context, builder: (context)=>AlertDialog(
      title: const Text("Confirm Delete"),
      content: const Text("Are you sure to delete this contact"),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context,false);
        }, child: const  Text("Cancel")),
        TextButton(onPressed: (){
          Navigator.pop(context,true);
        }, child: const Text("Yes"))
      ],
    ));

  }

   _fetchData() {
    if(index==0){
      Provider.of<ContactProvider>(context,listen: false).getAllContact();
    }else{
      Provider.of<ContactProvider>(context,listen: false).getFavoriteContact();
    }
   }
}
