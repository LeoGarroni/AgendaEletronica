// ignore_for_file: public_member_api_docs, sort_constructors_first, unnecessary_null_comparison
import 'dart:convert';


const String contactTable = "contactTable";
const String idColumn = "idColumn";
const String firstNameColumn = "firstNameColumn";
const String lastNameColumn = "lastNameColumn";
const String cpfColumn = "cpfColumn";
const String emailColumn = "emailColumn";
const String imgColumn = "imgColumn";
const String residentialPhoneColumn = "residentialPhoneColumn";
const String workPhoneColumn = "workPhoneColumn";
const String cellPhoneColumn = "cellPhoneColumn";


class ContactModel {

  int id;
  String firstName;
  String lastName;
  String cpf;
  String email;
  String img;
  String? residentialPhone;
  String? workPhone;
  String? cellPhone;
  
  ContactModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.cpf,
    required this.email,
    required this.img,
    this.residentialPhone,
    this.workPhone,
    this.cellPhone,
  });

  

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'idColumn': id,
      'firstNameColumn': firstName,
      'lastNameColumn': lastName,
      'cpfColumn': cpf,
      'emailColumn': email,
      'imgColumn': img,
      'residentialPhoneColumn': residentialPhone,
      'workPhoneColumn': workPhone,
      'cellPhoneColumn': cellPhone,
    };
    if(id != null) {
      map[idColumn] = id;
    }

    return map;
  }

  factory ContactModel.fromMap(Map map) {
    return ContactModel(
      id: map['idColumn'],
      firstName: map['firstNameColumn'],
      lastName: map['lastNameColumn'],
      cpf: map['cpfColumn'],
      email: map['emailColumn'],
      img: map['imgColumn'],
      residentialPhone: map['residentialPhoneColumn'],
      workPhone: map['workPhoneColumn'],
      cellPhone: map['cellPhoneColumn'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactModel.fromJson(String source) => ContactModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ContactModel(id: $id, firstName: $firstName, lastName: $lastName, cpf: $cpf, email: $email, img: $img, residentialPhone: $residentialPhone, workPhone: $workPhone, cellPhone: $cellPhone)';
  }
}
