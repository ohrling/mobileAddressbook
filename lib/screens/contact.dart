import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_adressbook/models/contact.dart';

class Contact extends StatelessWidget {
  final ContactModel contact;

  const Contact({
    Key key,
    @required this.contact,
  })  : assert(contact != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    print('inne i build i Contact');
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(
            top: 22.0, bottom: 22.0, left: 16.0, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              contact.firstName + ' ' + contact.lastName,
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              contact.phoneNr,
              style: TextStyle(
                fontSize: 10.0,
                color: Colors.grey.shade800,
              ),
            ),
            Text(
              contact.email,
              style: TextStyle(
                fontSize: 10.0,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
