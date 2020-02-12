import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_adressbook/models/contact.dart';
import 'package:mobile_adressbook/services/connection.dart';

class ContactInfoScreen extends StatelessWidget {
  final contact;

  ContactInfoScreen({this.contact});

  @override
  Widget build(BuildContext context) {
    String firstName;
    String lastName;
    String phoneNr;
    String email;

    if (contact != null) {
      firstName = contact.firstName;
      lastName = contact.lastName;
      phoneNr = contact.phoneNr;
      email = contact.email;
    }

    return MaterialApp(
      title: 'Lägg till kontakt',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Lägg till kontakt'),
          backgroundColor: Colors.blueGrey.shade700,
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.lightBlue.shade100,
                        hintText: contact == null ? 'Förnamn' : firstName,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            borderSide: BorderSide.none)),
                    onChanged: (value) {
                      firstName = value;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.lightBlue.shade100,
                        hintText: contact == null ? 'Efternamn' : lastName,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            borderSide: BorderSide.none)),
                    onChanged: (value) {
                      lastName = value;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.lightBlue.shade100,
                        hintText: contact == null ? 'Telefonnummer' : phoneNr,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            borderSide: BorderSide.none)),
                    onChanged: (value) {
                      phoneNr = value;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.lightBlue.shade100,
                        hintText: contact == null ? 'Email' : email,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            borderSide: BorderSide.none)),
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: MaterialButton(
                      child: Text('Spara'),
                      color: Colors.lightBlue.shade200,
                      onPressed: () {
                        ContactModel newContact;
                        if (contact != null) {
                          newContact = new ContactModel(
                              id: contact.id,
                              firstName: firstName.trim(),
                              lastName: lastName.trim(),
                              phoneNr: phoneNr.trim(),
                              email: email.trim());
                        } else {
                          newContact = new ContactModel(
                              id: null,
                              firstName: firstName.trim(),
                              lastName: lastName.trim(),
                              phoneNr: phoneNr.trim(),
                              email: email.trim());
                        }
                        print(newContact.phoneNr);

                        //networkHelper.addContact(newContact);
                        Navigator.pop(context, newContact);
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        resizeToAvoidBottomInset: true,
      ),
    );
  }
}
