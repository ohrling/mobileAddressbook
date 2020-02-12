import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:mobile_adressbook/models/contact.dart';
import 'package:mobile_adressbook/services/connection.dart';

class JsonHelper {
  Connector networkHelper = new Connector(
      'https://calm-anchorage-69461.herokuapp.com/api/v1/contact');
  Results results;

  Future<Results> getContactData() async {
    String contactData = await networkHelper.getData();
    results = Results.fromJson(jsonDecode(contactData));
    return results;
  }

  Future<bool> addContactData(ContactModel contact) async {
    return await networkHelper.addContact(contact);
  }

  Future<bool> deleteData(String id) async {
    return await networkHelper.deleteContact(id: id);
  }

  Future<bool> updateContact(ContactModel updated) async {
    return await networkHelper.updateContact(updated);
  }
}
