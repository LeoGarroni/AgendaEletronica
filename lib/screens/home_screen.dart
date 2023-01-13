// ignore_for_file: prefer_const_constructors, prefer_conditional_assignment, prefer_is_empty

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:group_software/screens/view_screen.dart';
import 'package:group_software/utils/app_colors.dart';

import '../data/contact_helper.dart';
import '../models/contact_model.dart';
import 'contact_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ContactHelper helper = ContactHelper();

  List<ContactModel> contacts = [];

 


  @override
  void initState() {
    super.initState();
    _getAllContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Contatos"),
          backgroundColor: AppColors.primary1,
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            _showContactScreen();
          },
          backgroundColor: AppColors.primary1,
          child: Icon(Icons.add),
        ),
        body: contacts.length == 0 ? Center(child: CircularProgressIndicator(),) :
        ListView.builder(
            padding: EdgeInsets.all(10.0),
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              return _contactCard(context, index);
            }));
  }

  Widget _contactCard(BuildContext context, int index) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Card(
          child: ListTile(
            leading: Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: contacts[index].img != ""
                                ? FileImage(File(contacts[index].img)) as ImageProvider
                                : AssetImage("images/person.png"),
                            fit: BoxFit.cover)),
            ),
            title: Text('${contacts[index].firstName} ${contacts[index].lastName}'),
            subtitle:
                Text(contacts[index].cellPhone! != "" ? contacts[index].cellPhone! : contacts[index].residentialPhone! != "" ? contacts[index].residentialPhone! : contacts[index].workPhone! != "" ? contacts[index].workPhone! : "Número não adicionado" ),
          ),
        ),
      ),
      onTap: () {
        _showOptions(context, index);
      },
    );
  }


  void _showOptions(BuildContext context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
            onClosing: () {},
            builder: (context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                      onPressed: () {        
                        _showViewScreen(contact: contacts[index]);
                      },
                      child: Text(
                        "Ver",
                        style: TextStyle(color: AppColors.fontblack, fontSize: 20.0),
                      )),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _showContactScreen(contact: contacts[index]);
                      },
                      child: Text(
                        "Editar",
                        style: TextStyle(color: AppColors.fontblack, fontSize: 20.0),
                      )),
                  TextButton(
                      onPressed: () {
                        helper.deleteContact(contacts[index].id);
                        setState(() {
                          contacts.removeAt(index);
                          Navigator.pop(context);
                        });
                      },
                      child: Text(
                        "Excluir",
                        style: TextStyle(color: AppColors.fontblack, fontSize: 20.0),
                      ))
                ],
              );
            },
          );
        });
  }

  void _showContactScreen({ContactModel? contact}) async {
    if(contact == null){
      contact = ContactModel(id: 0, firstName: "", lastName: "", cpf: "", email: "", img: "", residentialPhone: "", workPhone: "", cellPhone: "");
    }
    final recContact = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => ContactScreen(contact: contact!)));
    if (recContact != null) {
      if (contact.cpf != "") {
        await helper.updateContact(recContact);
      } else {
        await helper.saveContact(recContact);
      }
      _getAllContacts();
    }
  }

  void _showViewScreen({ContactModel? contact}) async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => ViewScreen(contact: contact!)));
  }


  void _getAllContacts() {
    helper.getAllContacts().then((list) {
      setState(() {
        contacts = list.cast<ContactModel>();
      });
    });
  }

}
