import 'package:flutter/material.dart';

AppBar MainAppBar(BuildContext context) {
  return AppBar(
    actions: [
      Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Container(
              child: IconButton(
                icon: Icon(Icons.dehaze),
                onPressed: () {},
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
                child:
                    IconButton(icon: const Icon(Icons.search), onPressed: () {}
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
