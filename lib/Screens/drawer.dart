import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vigenesia/Screens/profile.dart';

import 'login.dart';

class NavDrawer extends StatelessWidget {
  final String nick;
  final String name;
  final Function refresher;
  const NavDrawer({
    Key? key,
    required this.nick,
    required this.name,
    required this.refresher,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.green,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/cover1.jpg'),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: SizedBox(
                    child: CircleAvatar(
                      radius: 19.0,
                      child: Text(nick),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.5),
                    child: Text(
                      name,
                      style:
                          const TextStyle(color: Colors.black, fontSize: 19.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 3.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 19.0,
                      child: TextButton(
                        child: const Icon(
                          Icons.logout_rounded,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          SharedPreferences.getInstance().then(
                            (prefs) {
                              prefs.remove('email');
                              prefs.remove('nama');
                              prefs.remove('id');
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const Login(),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.only(left: 19.5),
            leading: const Icon(
              CupertinoIcons.person,
              size: 33.5,
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'PROFILE',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  width: 55,
                ),
              ],
            ),
            onTap: () {
              SharedPreferences.getInstance().then(
                (prefs) {
                  var id = prefs.getString('id');
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => Profile(
                        id: id!,
                        fromPage: "home",
                        currentUser: id,
                      ),
                    ),
                  ).then((value) => refresher());
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
