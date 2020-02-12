import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_adressbook/models/contact.dart';
import 'package:mobile_adressbook/screens/contact_info_screen.dart';
import 'package:mobile_adressbook/services/json_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ContactScreen extends StatefulWidget {
  final results;

  ContactScreen({this.results});

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final scrollController = ScrollController();

  List<ContactModel> contactsList = List<ContactModel>();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();

    initLoad(widget.results);
  }

  initLoad(dynamic apiData) {
    contactsList = apiData.contacts;
  }

  void onRefresh() async {
    await Future.delayed(Duration(milliseconds: 200));
    Results results = await JsonHelper().getContactData();
    contactsList = results.contacts;
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    Results results = await JsonHelper().getContactData();
    contactsList = results.contacts;
    setState(() {});
    refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adressbok',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Adressbok'),
          backgroundColor: Colors.blueGrey.shade700,
        ),
        body: Container(
          child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            header: WaterDropMaterialHeader(),
            footer: CustomFooter(
              builder: (BuildContext context, LoadStatus mode) {
                Widget body;
                if (mode == LoadStatus.loading) {
                  body = Text('Dra för att ladda');
                } else if (mode == LoadStatus.failed) {
                  body = Text('Kunde inte ladda, klicka för nytt försök');
                } else if (mode == LoadStatus.canLoading) {
                  body = Text('Släpp för att ladda mer');
                } else {
                  body = Text('Ingen mer data');
                }
                return Container(
                  height: 55.0,
                  child: Center(
                    child: body,
                  ),
                );
              },
            ),
            controller: refreshController,
            onRefresh: onRefresh,
            onLoading: onLoading,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 22.0, bottom: 22.0, left: 16.0, right: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              contactsList[index].firstName +
                                  ' ' +
                                  contactsList[index].lastName,
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              contactsList[index].phoneNr,
                              style: TextStyle(
                                fontSize: 10.0,
                                color: Colors.grey.shade800,
                              ),
                            ),
                            Text(
                              contactsList[index].email,
                              style: TextStyle(
                                fontSize: 10.0,
                                color: Colors.grey.shade700,
                              ),
                            )
                          ],
                        ),
                      ),
                      Column(children: <Widget>[
                        FlatButton(
                          child: Icon(
                            Icons.edit,
                            size: 10.0,
                            color: Colors.green.shade200,
                          ),
                          onPressed: () async {
                            ContactModel updated = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ContactInfoScreen(
                                    contact: contactsList[index],
                                  );
                                },
                              ),
                            );
                            if (updated != null) {
                              print('contact_screen newcontact = ' +
                                  updated.firstName);
                              if (await JsonHelper().updateContact(updated)) {
                                onLoading();
                              }
                            }
                          },
                        ),
                        FlatButton(
                          child: Icon(
                            Icons.delete,
                            size: 10.0,
                            color: Colors.redAccent,
                          ),
                          onPressed: () {
                            if (JsonHelper()
                                    .deleteData(contactsList[index].id) !=
                                null) {
                              onLoading();
                            }
                          },
                        )
                      ])
                    ],
                  ),
                );
              },
              itemCount: contactsList.length,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            ContactModel newContact = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ContactInfoScreen();
                },
              ),
            );
            if (newContact != null) {
              print('contact_screen newcontact = ' + newContact.firstName);
              if (await JsonHelper().addContactData(newContact)) {
                onLoading();
              }
            }
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.lightBlue,
        ),
      ),
    );
  }
}

class MyDialogContent extends StatefulWidget {
  MyDialogContent({Key key}) : super(key: key);

  @override
  _MyDialogContent createState() => _MyDialogContent();
}

class _MyDialogContent extends State<MyDialogContent> {
  List<ContactModel> contacts = new List<ContactModel>();

  @override
  void initState() {
    super.initState();
  }

  updateList() async {
    setState(() async {
      Results results = await JsonHelper().getContactData();
      contacts = results.contacts;
    });
  }

  getContacts() {
    if (contacts.length == 0) {
      return new Container();
    }

    return new Container(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 22.0, bottom: 22.0, left: 16.0, right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    contacts[index].firstName + ' ' + contacts[index].lastName,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    contacts[index].phoneNr,
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  Text(
                    contacts[index].email,
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: contacts.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return null;
    //return getContacts();
  }
}
