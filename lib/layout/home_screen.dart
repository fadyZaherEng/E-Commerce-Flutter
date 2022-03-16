import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_technical_task/layout/home_provider.dart';
import 'package:flutter_technical_task/modules/login/login_screen.dart';
import 'package:flutter_technical_task/shared/components/components.dart';
import 'package:flutter_technical_task/shared/network/local/cashe_helper.dart';
import 'package:flutter_technical_task/utils/ar.dart';
import 'package:flutter_technical_task/utils/en.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var obj=Provider.of<HomeProvider>(context,listen: true);
    return Builder(
      builder: (context) {
           Provider.of<HomeProvider>(context,listen: false).getUserProfile();
        return Scaffold(
          appBar: AppBar(
            title:const Text('SOUQ'),
          ),
          body: obj.listScreen[obj.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items:   [
              BottomNavigationBarItem(icon: const Icon(Icons.home),
                label:SharedHelper.get(key: 'lang')=='en'?en['Home']!:ar['Home']!
                ,),
              BottomNavigationBarItem(icon:const Icon(Icons.person),
                label:SharedHelper.get(key: 'lang')=='en'?en['Profile']!:ar['Profile']!,),
            ],
            onTap: (index) {
              Provider.of<HomeProvider>(context,listen: false).changeNav(index);
            },
            currentIndex: obj.currentIndex,
            type: BottomNavigationBarType.fixed,
          ),
          drawer:Drawer(
            //end drawer right english w drawer left arabic
            child: Column(
              children: [
                if (obj.userProfile != null)
                  UserAccountsDrawerHeader(
                    accountName: Text(
                      obj.userProfile!.username,
                      style: SharedHelper.get(key: "theme") == 'Light Theme'
                          ? const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white)
                          : TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color:HexColor('000028')),
                    ),
                    accountEmail: Text(
                      obj.userProfile!.email,
                      style: SharedHelper.get(key: "theme") == 'Light Theme'
                          ? const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                          color: Colors.white)
                          : TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                          color: HexColor('000028')),
                    ),
                    decoration: BoxDecoration(color: Theme.of(context).primaryColor),
                  ),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(
                        start: 22, bottom: 10, top: 22),
                    child: Row(
                      children: [
                        CircleAvatar(
                            radius: 11,
                            backgroundColor: SharedHelper.get(key: 'theme') ==
                                'Light Theme'
                                ? Colors.pink
                                : Colors.pink,
                            child: Icon(
                              Icons.dark_mode_outlined,
                              color: SharedHelper.get(key: 'theme') ==
                                  'Light Theme'
                                  ? Colors.white
                                  : Colors.black,
                              size: 15,
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          SharedHelper.get(key: 'theme')=='Light Theme'?
                          (SharedHelper.get(key: 'lang')=='en'?en['Light Theme']!:ar['Light Theme']!):
                          ( SharedHelper.get(key: 'lang')=='en'?en['Dark Theme']!:ar['Dark Theme']! )
                          ,
                          style: Theme.of(context).textTheme.bodyText2,
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    Provider.of<HomeProvider>(context,listen: false).modeChange(context);
                    Provider.of<HomeProvider>(context,listen: true).mode;
                    },
                ),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(
                        start: 22, bottom: 10, top: 10),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.settings,
                          size: 20,
                          color: Colors.pink,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          SharedHelper.get(key: 'lang')=='en'?en['Settings']!:ar['Settings']!
                          ,
                          style: Theme.of(context).textTheme.bodyText2,
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    Provider.of<HomeProvider>(context,listen: false).changeSettings(context);
                  },
                ),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(
                        start: 22, bottom: 10, top: 10),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.logout,
                          size: 20,
                          color: Colors.pink,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          SharedHelper.get(key: 'lang')=='en'?en['Log Out']!:ar['Log Out']!,
                          style: Theme.of(context).textTheme.bodyText2,
                        )
                      ],
                    ),
                  ),
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    SharedHelper.remove(key: 'signIn');
                    SharedHelper.remove(key: 'uid');
                    navigateToWithoutReturn(context, LogInScreen());
                  },
                ),
              ],
            ),
          ),
        );
      }
    );
  }

}
