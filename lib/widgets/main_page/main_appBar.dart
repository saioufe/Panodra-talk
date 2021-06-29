import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pandora_talks/blocs/authentication_bloc/bloc.dart';
import 'package:pandora_talks/blocs/authentication_bloc/events.dart';

import '../../routes.dart';

AppBar MainAppBar(BuildContext context, GlobalKey<ScaffoldState> theKey) {
  return AppBar(
    leading: new Container(),
    actions: [
      Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Container(
              child: IconButton(
                icon: Icon(Icons.dehaze),
                onPressed: () {
                  theKey.currentState.openDrawer();
                },
                splashRadius: 25,
                splashColor: Colors.black26,
                highlightColor: Colors.black12,
              ),
            ),
            Container(
              child: Text(
                "Pandora Talk",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).canvasColor,
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    Navigator.of(context)?.pushNamed(RouteGenerator.searchPage);
                  },
                  splashRadius: 25,
                  splashColor: Colors.black26,
                  highlightColor: Colors.black12,
                  //  BlocProvider.of<AuthenticationBloc>(context).add(
                  //   LoggedOut(),
                  // ),
                ),
              ),
            ),
          ],
        ),
      )
    ],
  );
}
