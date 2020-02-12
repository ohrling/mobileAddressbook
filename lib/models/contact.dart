import 'package:json_annotation/json_annotation.dart';

part 'contact.g.dart';

class ContactModel {
  @JsonKey(name: 'id', nullable: false)
  final String id;
  @JsonKey(name: 'firstname', nullable: false)
  final String firstName;
  @JsonKey(name: 'lastname', nullable: false)
  final String lastName;
  @JsonKey(name: 'phoneNr', nullable: true)
  final String phoneNr;
  @JsonKey(name: 'email', nullable: true)
  final String email;

  ContactModel(
      {this.id, this.firstName, this.lastName, this.phoneNr, this.email});

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    print('contactModel json = ' + json.toString());
    return ContactModel(
        id: json['id'],
        firstName: json['firstname'],
        lastName: json['lastname'],
        phoneNr: json['phoneNr'],
        email: json['email']);
  }

  Map<String, dynamic> toJson() => {
        'firstname': firstName,
        'lastname': lastName,
        'phoneNr': phoneNr,
        'email': email,
      };
}

class Results {
  final List<ContactModel> contacts;

  Results({this.contacts});

  factory Results.fromJson(json) {
    return Results(contacts: parseContacts(json));
  }

  static List parseContacts(json) {
    print(json);
    var results = json['results'];
    List<ContactModel> contacts = List<ContactModel>.from(
        results.map((data) => ContactModel.fromJson(data)));
    return contacts;
  }
}
