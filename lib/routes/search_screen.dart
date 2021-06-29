import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contact/contacts.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:line_icons/line_icon.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen();

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController;
  //List<Map<Contact, bool>> listContacts;

  List<List<dynamic>> twoDList;
  @override
  void initState() {
    searchController = TextEditingController(text: "");
    //listContacts = new List();
    twoDList = List.empty();

    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  bool isLoading = false;

  Future readContacts(String name) async {
    await _getPermission();
    //listContacts = List();
    twoDList = List();
    List<Contact> contacts = [];

    await Contacts.streamContacts(
            query: name.replaceAll(new RegExp(r'[\u200f]'), ""))
        .forEach((contact) async {
      setState(() {
        isLoading = true;
      });
      if (contact.phones.length > 0) {
        contacts.add(contact);
      }
    });
    setState(() {
      isLoading = false;
    });
    print(contacts.length);

    contacts.forEach((contact) async {
      var theNumber;
      if (contact.phones.length > 0) {
        if (contact.phones[0].value.startsWith("078")) {
          theNumber = contact.phones[0].value.replaceAll("078", "+96478");
        }
        if (contact.phones[0].value.startsWith("079")) {
          theNumber = contact.phones[0].value.replaceAll("079", "+96479");
        }
        if (contact.phones[0].value.startsWith("077")) {
          theNumber = contact.phones[0].value.replaceAll("077", "+96477");
        }
        if (contact.phones[0].value.startsWith("075")) {
          theNumber = contact.phones[0].value.replaceAll("075", "+96475");
        }
        theNumber = contact.phones[0].value.replaceAll(" ", "");

        bool isOldUser;
        print("this is the number to check : " + theNumber.toString());

        CollectionReference users =
            FirebaseFirestore.instance.collection('Users ');

        await users
            .where("phone", isEqualTo: theNumber.toString())
            .get()
            .then((value) {
          if (value.docs.length != 0) {
            isOldUser = true;
            setState(() {
              twoDList.add([contact, isOldUser]);
            });
          } else {
            isOldUser = false;
            setState(() {
              twoDList.add([contact, isOldUser]);
            });
          }
        });
      }
    });
  }

  //Check contacts permission
  Future _getPermission() async {
    final permission = await Permission.contacts.status;
    if (permission != PermissionStatus.denied ||
        permission != PermissionStatus.restricted ||
        permission != PermissionStatus.permanentlyDenied) {
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
                      textInputAction: TextInputAction.search,
                      // onChanged: (name) {
                      //   setState(() {
                      //     if (name != "") {
                      //       readContacts(name);
                      //     }
                      //   });
                      // },
                      onFieldSubmitted: (name) {
                        setState(() {
                          if (name != "") {
                            readContacts(name);
                          }
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
            twoDList.length > 0
                ? Container(
                    child:
                        // (listContacts.length > 0)
                        // ?
                        isLoading == false
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: twoDList.length,
                                itemBuilder: (context, index) {
                                  var contact = twoDList[index][0] as Contact;
                                  var isOldUser = twoDList[index][1] as bool;

                                  return Card(
                                    elevation: 3,
                                    shadowColor: Colors.grey.withOpacity(0.1),
                                    child: ListTile(
                                        // leading: CircleAvatar(
                                        //   backgroundColor: Colors.green,
                                        //   child: Center(
                                        //     child: (contact.avatar != null)
                                        //         ? Image.memory(
                                        //             contact.avatar,
                                        //             height: 28,
                                        //             width: 28,
                                        //           )
                                        //         : Icon(Icons.face),
                                        //   ),
                                        // ),

                                        title: Text("${contact.displayName}"),
                                        subtitle: Text((contact.phones.length >
                                                0)
                                            ? "${contact.phones.get(0).value.replaceAll("078", "+96478").replaceAll("077", "+96477").replaceAll("075", "+96475").replaceAll(" ", "")}"
                                            : "No contact"),
                                        trailing: InkWell(
                                          child: isOldUser == false
                                              ? Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      6,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    color: Colors.redAccent,
                                                  ),
                                                  padding: EdgeInsets.all(10),
                                                  child: Center(
                                                    child: Text(
                                                      "Invite",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  height: 40,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      6,
                                                  decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                  padding: EdgeInsets.all(13),
                                                  child: Center(
                                                    child: Text(
                                                      "Chat",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                          onTap: () {
                                            if (isOldUser == false) {
                                              String message =
                                                  "hi my name is Saif i want to chat with you on https://pandoradevs.com";
                                              List<String> recipents = [
                                                "${contact.phones.get(0).value.replaceAll("078", "+96478").replaceAll("077", "+96477").replaceAll("075", "+96475").replaceAll(" ", "")}",
                                              ];

                                              _sendSMS(message, recipents);
                                            }
                                            // _makePhoneCall(
                                            //     "tel:${contact.phones.length.gcd(0)}");
                                          },
                                        )),
                                  );
                                })
                            : CircularProgressIndicator(),
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
                  )
                : Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 1.4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            LineIcon.users().icon,
                            size: 50,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "ابحث عن اصدقائك الجدد الان",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  void _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
    print(_result);
  }
}
