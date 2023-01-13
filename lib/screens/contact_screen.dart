// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors, unnecessary_null_comparison, invalid_use_of_visible_for_testing_member

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:group_software/utils/app_colors.dart';

import '../models/contact_model.dart';

class ContactScreen extends StatefulWidget {
  final ContactModel contact;

  const ContactScreen({
    Key? key,
    required this.contact,
  }) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final cpfController = TextEditingController();
  final emailController = TextEditingController();
  final residentialPhoneController = TextEditingController();
  final workPhoneController = TextEditingController();
  final cellPhoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final formValidVN = ValueNotifier<bool>(false);

  final _nameFocus = FocusNode();

  bool _userEdited = false;

  ContactModel? _editedContact;

  var maskTel = MaskTextInputFormatter(
  mask: '(##) #####-####', 
  filter: { "#": RegExp(r'[0-9]') },
  type: MaskAutoCompletionType.lazy
);

var maskCpf = MaskTextInputFormatter(
  mask: '###.###.###-##', 
  filter: { "#": RegExp(r'[0-9]') },
  type: MaskAutoCompletionType.lazy
);


  @override
  void initState() {
    super.initState();

    if (widget.contact == null) {
      _editedContact = ContactModel(id:0,firstName: "", lastName: "", cpf: "", email: "", img: "", residentialPhone: "", workPhone: "", cellPhone: "");
    } else {
      _editedContact = ContactModel.fromMap(widget.contact.toMap());

      firstNameController.text = _editedContact!.firstName;
      lastNameController.text = _editedContact!.lastName;
      cpfController.text = _editedContact!.cpf;
      emailController.text = _editedContact!.email;
      residentialPhoneController.text = _editedContact!.residentialPhone!;
      workPhoneController.text = _editedContact!.workPhone!;
      cellPhoneController.text = _editedContact!.cellPhone!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primary1,
            title: Text(_editedContact!.firstName == "" ? "Novo Contato":_editedContact!.firstName),
            centerTitle: true,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (_editedContact!.cpf.length > 13) {
                Navigator.pop(context, _editedContact);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
                FocusScope.of(context).requestFocus(_nameFocus);
              }
            },
            backgroundColor: AppColors.primary1,
            child: Icon(Icons.save),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              onChanged: () {
                formValidVN.value = _formKey.currentState?.validate() ?? false;
              },
              child: Column(
                children:[
                  GestureDetector(
                    child: Container(
                      width: 140.0,
                      height: 140.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: _editedContact!.img != ""
                                ? FileImage(File(_editedContact!.img)) as ImageProvider
                                : AssetImage("images/person.png"),
                            fit: BoxFit.cover)),
                    ),
                    onTap: () async  {
                       await ImagePicker.platform.pickImage(source: ImageSource.camera)
                          .then((file) {
                        if (file == null) return;
                        setState(() {
                          _editedContact!.img = file.path;
                        });
                      });
                    },
                  ),
                  SizedBox(height: 30,),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text('Informações: ',
                    style: TextStyle(color: AppColors.primary1),
                    )),
                  SizedBox(height: 15,),
                  TextFormField(
                        controller: firstNameController,
                        keyboardType: TextInputType.text,
                        cursorColor: AppColors.primary1,
                        style: TextStyle(
                            color: AppColors.darkcolor1,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                          hintText: 'Nome',
                          hintStyle: TextStyle(
                              color: AppColors.lightcolor1,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                          filled: false,
                          contentPadding: EdgeInsets.fromLTRB(
                              20,
                              14,
                              20,
                              14),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.primary1),
                            borderRadius:
                                BorderRadius.circular(4),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.fieldbackground),
                            borderRadius:
                                BorderRadius.circular(4),
                          ),
                        ),
                        onChanged: (text) {
                      _userEdited = true;
                      setState(() {
                        _editedContact!.firstName = text;
                      });
                    },
                      ),
                      SizedBox(height: 15,),
                  TextFormField(
                        controller: lastNameController,
                        keyboardType: TextInputType.text,
                        cursorColor: AppColors.primary1,
                        style: TextStyle(
                            color: AppColors.darkcolor1,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                          hintText: 'Sobrenome',
                          hintStyle: TextStyle(
                              color: AppColors.lightcolor1,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                          filled: false,
                          contentPadding: EdgeInsets.fromLTRB(
                              20,
                              14,
                              20,
                              14),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.primary1),
                            borderRadius:
                                BorderRadius.circular(4),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.fieldbackground),
                            borderRadius:
                                BorderRadius.circular(4),
                          ),
                        ),
                        onChanged: (text) {
                      _userEdited = true;
                      setState(() {
                        _editedContact!.lastName = text;
                      });
                    },
                      ),
                      SizedBox(height: 15,),
                  TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: AppColors.primary1,
                        style: TextStyle(
                            color: AppColors.darkcolor1,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                          hintText: 'E-mail',
                          hintStyle: TextStyle(
                              color: AppColors.lightcolor1,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                          filled: false,
                          contentPadding: EdgeInsets.fromLTRB(
                              20,
                              14,
                              20,
                              14),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.primary1),
                            borderRadius:
                                BorderRadius.circular(4),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.fieldbackground),
                            borderRadius:
                                BorderRadius.circular(4),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.fontred1),
                            borderRadius:
                                BorderRadius.circular(4),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.primary1),
                            borderRadius:
                                BorderRadius.circular(4),
                          ),
                        ),
                        validator: _validarEmail,
                        onChanged: (text) {
                      _userEdited = true;
                      setState(() {
                        _editedContact!.email = text;
                      });
                    },
                      ),
                      SizedBox(height: 15,),
                      TextFormField(
                        controller: cpfController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [maskCpf],
                        cursorColor: AppColors.primary1,
                        style: TextStyle(
                            color: AppColors.darkcolor1,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                          hintText: 'CPF',
                          hintStyle: TextStyle(
                              color: AppColors.lightcolor1,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                          filled: false,
                          contentPadding: EdgeInsets.fromLTRB(
                              20,
                              14,
                              20,
                              14),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.primary1),
                            borderRadius:
                                BorderRadius.circular(4),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.fieldbackground),
                            borderRadius:
                                BorderRadius.circular(4),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.fontred1),
                            borderRadius:
                                BorderRadius.circular(4),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.primary1),
                            borderRadius:
                                BorderRadius.circular(4),
                          ),
                        ),
                        validator: validarCPF,
                        onChanged: (text) {
                      _userEdited = true;
                      setState(() {
                        _editedContact!.cpf = text;
                      });
                    },
                      ),
                      SizedBox(height: 15,),
                      Container(
                    alignment: Alignment.topLeft,
                    child: Text('Telefones: ',
                    style: TextStyle(color: AppColors.primary1),
                    )),
                  SizedBox(height: 15,),
                      TextFormField(
                        controller: residentialPhoneController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [maskTel],
                        cursorColor: AppColors.primary1,
                        style: TextStyle(
                            color: AppColors.darkcolor1,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                          hintText: 'Residencial',
                          hintStyle: TextStyle(
                              color: AppColors.lightcolor1,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                          filled: false,
                          contentPadding: EdgeInsets.fromLTRB(
                              20,
                              14,
                              20,
                              14),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.primary1),
                            borderRadius:
                                BorderRadius.circular(4),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.fieldbackground),
                            borderRadius:
                                BorderRadius.circular(4),
                          ),
                        ),
                        onChanged: (text) {
                      _userEdited = true;
                      setState(() {
                        _editedContact!.residentialPhone = text;
                      });
                    },
                      ),
                      SizedBox(height: 15,),
                      TextFormField(
                        controller: workPhoneController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [maskTel],
                        cursorColor: AppColors.primary1,
                        style: TextStyle(
                            color: AppColors.darkcolor1,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                          hintText: 'Trabalho',
                          hintStyle: TextStyle(
                              color: AppColors.lightcolor1,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                          filled: false,
                          contentPadding: EdgeInsets.fromLTRB(
                              20,
                              14,
                              20,
                              14),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.primary1),
                            borderRadius:
                                BorderRadius.circular(4),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.fieldbackground),
                            borderRadius:
                                BorderRadius.circular(4),
                          ),
                        ),
                        onChanged: (text) {
                      _userEdited = true;
                      setState(() {
                        _editedContact!.workPhone = text;
                      });
                    },
                      ),
                      SizedBox(height: 15,),
                      TextFormField(
                        controller: cellPhoneController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [maskTel],
                        cursorColor: AppColors.primary1,
                        style: TextStyle(
                            color: AppColors.darkcolor1,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                          hintText: 'Celular',
                          hintStyle: TextStyle(
                              color: AppColors.lightcolor1,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                          filled: false,
                          contentPadding: EdgeInsets.fromLTRB(
                              20,
                              14,
                              20,
                              14),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.primary1),
                            borderRadius:
                                BorderRadius.circular(4),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.fieldbackground),
                            borderRadius:
                                BorderRadius.circular(4),
                          ),
                        ),
                        onChanged: (text) {
                      _userEdited = true;
                      setState(() {
                        _editedContact!.cellPhone = text;
                      });
                    },
                      ),
                      SizedBox(height: 50,),
                ],
              ),
            ),
          ),
        ));
  }

   final snackbar = SnackBar(
    content: Text(
      'Digite os campos corretamente',
      textAlign: TextAlign.center,
      style: TextStyle(
          fontFamily: 'Montserrat',
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w300),
    ),
    backgroundColor: Colors.red,
  );

  Future<bool> _requestPop() {
    if (_userEdited) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Descartar Alteraçōes?"),
              content: Text("Se sair as alteraçōes serão perdidas."),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary1),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancelar")),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary1),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text("Sim"))
              ],
            );
          });
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  String? validarCPF(String? value) {
  if (value!.isEmpty) {
    return "Campo obrigatório";
  }  else if (value.length < 14){
    return "Complete o CPF";
  }else {
    return null;
  }
}

String? _validarEmail(String? value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value!)) {
    return "E-mail inválido";
  } else {
    return null;
  }
}

}
