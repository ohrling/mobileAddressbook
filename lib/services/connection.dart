import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mobile_adressbook/models/contact.dart';

class Connector {
  final String url;

  Connector(this.url);

  Future getData() async {
    http.Response response = await http
        .get(url); // , headers : {HttpHeaders.authorizationHeader: "TOKEN"},
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response.statusCode);
    }
  }

  Future getContact({id}) async {
    http.Response response = await http.get(url +
        "/" +
        id); // , headers : {HttpHeaders.authorizationHeader: "TOKEN"},
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print('fel ' +
          response.statusCode.toString() +
          ' ' +
          response.reasonPhrase);
    }
  }

  Future<bool> addContact(ContactModel contact) async {
    Map body = contact.toJson();
    print('addContact' + body.toString());
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(jsonEncode(body)));

    HttpClientResponse response = await request.close();

    if (response.statusCode < 200 && response.statusCode > 300) {
      print(await response.transform(utf8.decoder).join());
      httpClient.close();
      return true;
    } else {
      print('fel ' +
          response.statusCode.toString() +
          ' ' +
          response.reasonPhrase);
      return false;
    }
  }

  Future updateContact(ContactModel contact) async {
    Map body = contact.toJson();
    print('updateContact' + body.toString());
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request =
        await httpClient.putUrl(Uri.parse(url + "/" + contact.id));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(jsonEncode(body)));

    HttpClientResponse response = await request.close();

    if (response.statusCode > 199 && response.statusCode < 300) {
      return true;
    } else {
      print('fel ' +
          response.statusCode.toString() +
          ' ' +
          response.reasonPhrase);
      return false;
    }
  }

  Future deleteContact({id}) async {
    http.Response response = await http.delete(url + "/" + id);
    if (response.statusCode < 200 && response.statusCode > 300) {
      return true;
    }
    print(
        'fel ' + response.statusCode.toString() + ' ' + response.reasonPhrase);
    return false;
  }
}
