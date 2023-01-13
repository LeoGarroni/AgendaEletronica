// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors, deprecated_member_use
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:group_software/models/contact_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/app_colors.dart';

class ViewScreen extends StatefulWidget {
  final ContactModel contact;

  const ViewScreen({
    Key? key,
    required this.contact,
  }) : super(key: key);
  

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("${widget.contact.firstName} ${widget.contact.lastName}"),
          backgroundColor: AppColors.primary1,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left:20,right: 20, top: 20),
            child: Column(
              children: [
                Center(
                  child: Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: widget.contact.img != ""
                                    ? FileImage(File(widget.contact.img)) as ImageProvider
                                    : AssetImage("images/person.png"),
                                fit: BoxFit.cover)),
                        ),
                ),
                SizedBox(height: 20,),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text('Informações: ',
                        style: TextStyle(color: AppColors.primary1),
                        ),
                ),
                SizedBox(height: 10,),
                Container(
                  decoration: BoxDecoration(
                    color:AppColors.fieldbackground,
          borderRadius: BorderRadius.circular(10),
          ),
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("E-mail: ${widget.contact.email}",
                      style: TextStyle(color: AppColors.fontblack, fontSize: 12),),
                      SizedBox(height: 10,),
                      Text("CPF: ${widget.contact.cpf}",
                      style: TextStyle(color: AppColors.fontblack, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text('Telefones: ',
                        style: TextStyle(color: AppColors.primary1),
                        ),
                ),
                SizedBox(height: 15,),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color:AppColors.fieldbackground,
          borderRadius: BorderRadius.circular(10),
          ),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                      child: Text("Celular: ${widget.contact.cellPhone}",
                      style: TextStyle(color: AppColors.primary1, fontWeight: FontWeight.w700)),
                      onPressed: () => {
                        launch("tel:${widget.contact.cellPhone}")
                      },
                      ),
                      
                    ],
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color:AppColors.fieldbackground,
          borderRadius: BorderRadius.circular(10),
          ),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                      child: Text("Residencial: ${widget.contact.residentialPhone}",
                      style: TextStyle(color: AppColors.primary1, fontWeight: FontWeight.w700)),
                      onPressed: () => {
                        launch("tel:${widget.contact.residentialPhone}")
                      },
                      ),
                    ],
                  ),
                ),
                 SizedBox(height: 15,),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color:AppColors.fieldbackground,
          borderRadius: BorderRadius.circular(10),
          ),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                      child: Text("Trabalho: ${widget.contact.workPhone}",
                      style: TextStyle(color: AppColors.primary1, fontWeight: FontWeight.w700)),
                      onPressed: () => {
                        launch("tel:${widget.contact.workPhone}")
                      },
                      ),
                      
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    );
    
  }
}