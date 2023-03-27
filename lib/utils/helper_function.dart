import 'package:flutter/material.dart';

void showMsg(BuildContext context, String msg){
   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
}

showSingleTextInputDialog({
   required BuildContext context,
   required String title,
   TextInputType inputType = TextInputType.text,
   required Function (String) onUpate,
}){
   final controller = TextEditingController();
   showDialog(context: context, builder: (context)=>AlertDialog(
      title: Text("Update $title"),
      content: Padding(
         padding: EdgeInsets.all(8),
         child: TextField(
            keyboardType: inputType,
            controller: controller,
            decoration: InputDecoration(
               hintText: "Enter new $title",
               border: OutlineInputBorder(),
            ),
         ),
      ),
      actions: [
         TextButton(onPressed: (){
            Navigator.pop(context);
         }, child: Text("Cancel")),
         TextButton(onPressed: (){
            if(controller.text.isEmpty)return;
            onUpate(controller.text);
            Navigator.pop(context);

         }, child: Text("Update"))
      ],
   ));
}