import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contact/contacts.dart';
import 'package:permission_handler/permission_handler.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen();

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController;
  List<Contact> listContacts;
  @override
  void initState() {
    searchController = TextEditingController(text: "");
    listContacts = new List();
    readContacts("");
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  Future readContacts(String name) async {
    await _getPermission();
    listContacts = [];
    await Contacts.streamContacts(query: name).forEach((contact) {
      print("${contact.displayName}");
      setState(() {
        listContacts.add(contact);
      });
    });
  }

  //Check contacts permission
  Future _getPermission() async {
    final permission = await Permission.contacts.status;
    if (permission != PermissionStatus.denied) {
      final permissionStatus = await [Permission.contacts].request();
      return permissionStatus[Permission.contacts];
    } else {
      return permission;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new Container(),
        actions: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Container(
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      size: 30,
                    ),
                    onPressed: () {
                      // theKey.currentState.openDrawer();
                      Navigator.pop(context);
                    },
                    splashRadius: 25,
                    splashColor: Colors.black26,
                    highlightColor: Colors.black12,
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () async {},
                    child: Container(
                        child: TextFormField(
                      controller: searchController,
                      onChanged: (name) {
                        setState(() {
                          readContacts(name);
                        });
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        focusColor: Colors.transparent,
                        fillColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        hintText: "Search",
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                          color: Theme.of(context).canvasColor,
                        ),
                      ),
                    )),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                child:
                    // (listContacts.length > 0)
                    // ?
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: listContacts.length,
                        itemBuilder: (context, index) {
                          Contact contact = listContacts.get(index);
                          return Card(
                            child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.green,
                                  child: Center(
                                    child: (contact.avatar != null)
                                        ? Image.memory(
                                            contact.avatar,
                                            height: 28,
                                            width: 28,
                                          )
                                        : Icon(Icons.face),
                                  ),
                                ),
                                title: Text("${contact.displayName}"),
                                subtitle: Text((contact.phones.length > 0)
                                    ? "${contact.phones.get(0)}"
                                    : "No contact"),
                                trailing: InkWell(
                                  child: Icon(
                                    Icons.call,
                                    color: Colors.green,
                                  ),
                                  onTap: () {
                                    // _makePhoneCall(
                                    //     "tel:${contact.phones.length.gcd(0)}");
                                  },
                                )),
                          );
                        })
                // : Center(
                //     child: Column(
                //       mainAxisSize: MainAxisSize.min,
                //       children: [
                //         CircularProgressIndicator(
                //           backgroundColor: Colors.red,
                //         ),
                //         Text("reading Contacts...")
                //       ],
                //     ),
                //   ),
                ),
          ],
        ),
      ),
    );
  }
}
