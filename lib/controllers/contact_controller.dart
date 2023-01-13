// ignore_for_file: prefer_final_fields

import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/contact_model.dart';
import '../models/response_api_model.dart';


class ContactController extends GetxController with StateMixin{

  List<ContactModel> _contacts = [];
  List<ContactModel>? get contacts => _contacts;


  Future<String> postCpf() async {
    var url = Uri.parse('https://www.4devs.com.br/ferramentas_online.php');
    var response =
        await http.post(url, headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: {
        'acao': 'gerar_cpf'
          }
         );
         return response.body;
  }

  Future<void> getContacts() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/users');
    var response =
        await http.get(url);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      List<dynamic> itens = body.map((e) => ResponseApiModel.fromMap(e)).toList();
      for (var element in itens) {
        String cpf = await postCpf();
      _contacts.add(ContactModel(id: element.id, firstName: element.name, lastName: "", cpf: cpf, email: element.email, img: "", cellPhone: element.phone, residentialPhone: "", workPhone: ""));
      }
      update();
    } else {
    }
  }
}