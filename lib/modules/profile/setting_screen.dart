// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_technical_task/layout/home_provider.dart';
import 'package:flutter_technical_task/modules/map/screen_address.dart';
import 'package:flutter_technical_task/shared/components/components.dart';
import 'package:flutter_technical_task/shared/network/local/cashe_helper.dart';
import 'package:flutter_technical_task/utils/ar.dart';
import 'package:flutter_technical_task/utils/en.dart';
import 'package:provider/provider.dart';
import 'package:remedi_permission/remedi_permission.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var phoneController = TextEditingController();
  var userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var obj = Provider.of<HomeProvider>(context, listen: true);
    return SingleChildScrollView(
      child: ConditionalBuilder(
        condition: obj.userProfile != null,
        builder: (context) {
          initialComponents(obj);
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: getBody(context),
              ),
            ),
          );
        },
        fallback: (context) => const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
        ),
      ),
    );
  }

  Widget getBody(context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text(
                            SharedHelper.get(key: 'lang') == 'en'
                                ? en['Change Language']!
                                : ar['Change Language']!,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          content: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                child: Text(
                                  SharedHelper.get(key: 'lang') == 'en'
                                      ? en['English']!
                                      : ar['English']!,
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                                onTap: () {
                                  Provider.of<HomeProvider>(context,
                                          listen: false)
                                      .changeLanguage('en');
                                  Provider.of<HomeProvider>(context,
                                          listen: false)
                                      .myLang;
                                  Provider.of<HomeProvider>(context,
                                          listen: false)
                                      .navigte(context);
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                child: Text(
                                  SharedHelper.get(key: 'lang') == 'en'
                                      ? en['Arabic']!
                                      : ar['Arabic']!,
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                                onTap: () {
                                  Navigator.of(context);
                                  Provider.of<HomeProvider>(context,
                                          listen: false)
                                      .navigte(context);
                                  Provider.of<HomeProvider>(context,
                                          listen: false)
                                      .changeLanguage('ar');
                                  Provider.of<HomeProvider>(context,
                                          listen: false)
                                      .myLang;
                                },
                              )
                            ],
                          ),
                        ));
              },
              child: Text(
                SharedHelper.get(key: 'lang') == 'en'
                    ? en['Language']!
                    : ar['Language']!,
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (context) => PermissionPage(
                        viewModel: PermissionViewModel(
                          repository: PermissionRepository(
                            AppPermission(
                              Permission.notification,
                              title: 'Notification',
                              errorDescription: '',
                              mandatory: false,
                              description:
                                  'Please grant Notification Permission',
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: Text(
                    SharedHelper.get(key: 'lang') == 'en'
                        ? en['Notification']!
                        : ar['Notification']!,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
              ),
              const SizedBox(
                width: 2,
              ),
              Expanded(
                child: OutlinedButton(
                    onPressed: () {
                      askPermission(context);
                    },
                    child: Text(
                      SharedHelper.get(key: 'lang') == 'en'
                          ? en['Location']!
                          : ar['Location']!,
                      style: Theme.of(context).textTheme.caption,
                    )),
              ),
              const SizedBox(
                width: 2,
              ),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    navigateToWithReturn(context, AddressScreen());
                  },
                  child: Text(
                    SharedHelper.get(key: 'lang') == 'en'
                        ? en['Address']!
                        : ar['Address']!,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                child: defaultTextForm(
                  key: 'First Name ',
                  context: context,
                  type: TextInputType.text,
                  Controller: firstNameController,
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.pink,
                  ),
                  text: SharedHelper.get(key: 'lang') == 'en'
                      ? en['FirstName']!
                      : ar['FirstName']!,
                  validate: (val) {
                    if (val.toString().isEmpty) {
                      return 'Please Enter Your First Name';
                    }
                    return null;
                  },
                  onSubmitted: () {},
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: defaultTextForm(
                  key: 'Last Name ',
                  context: context,
                  type: TextInputType.text,
                  Controller: lastNameController,
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.pink,
                  ),
                  text: SharedHelper.get(key: 'lang') == 'en'
                      ? en['LastName']!
                      : ar['LastName']!,
                  validate: (val) {
                    if (val.toString().isEmpty) {
                      return 'Please Enter Your Last Name';
                    }
                    return null;
                  },
                  onSubmitted: () {},
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          defaultTextForm(
            key: 'Username',
            context: context,
            type: TextInputType.text,
            Controller: userNameController,
            prefixIcon: const Icon(
              Icons.person,
              color: Colors.pink,
            ),
            text: SharedHelper.get(key: 'lang') == 'en'
                ? en['Username']!
                : ar['Username']!,
            validate: (val) {
              if (val.toString().isEmpty) {
                return 'Please Enter Your Username';
              }
              return null;
            },
            onSubmitted: () {},
          ),
          const SizedBox(
            height: 10,
          ),
          defaultTextForm(
            key: 'phone',
            context: context,
            type: TextInputType.phone,
            Controller: phoneController,
            prefixIcon: const Icon(
              Icons.phone,
              color: Colors.pink,
            ),
            text: SharedHelper.get(key: 'lang') == 'en'
                ? en['Phone']!
                : ar['Phone']!,
            validate: (val) {
              if (val.toString().isEmpty) {
                return 'Please Enter Your Phone';
              }
              return null;
            },
            onSubmitted: () {},
          ),
          const SizedBox(
            height: 10,
          ),
          defaultTextForm(
            key: 'email',
            context: context,
            type: TextInputType.emailAddress,
            Controller: emailController,
            prefixIcon: const Icon(
              Icons.email,
              color: Colors.pink,
            ),
            text: SharedHelper.get(key: 'lang') == 'en'
                ? en['Email']!
                : ar['Email']!,
            validate: (val) {
              if (val.toString().isEmpty) {
                return 'Please Enter Your Email';
              }
              return null;
            },
            onSubmitted: () {},
          ),
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: Container(
              color: Colors.black,
              height: 40,
              width: 70,
              child: Center(
                child: IconButton(
                  onPressed: () {
                    var obj=Provider.of<HomeProvider>(context,listen: false);
                    obj.userProfile!.password=passwordController.text;
                    obj.userProfile!.email=emailController.text;
                    obj.userProfile!.name!.firstname=firstNameController.text;
                    obj.userProfile!.name!.lastname=lastNameController.text;
                    obj.userProfile!.username=userNameController.text;
                    obj.userProfile!.phone=phoneController.text;
                    Provider.of<HomeProvider>(context,listen: false).editUser();
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.pink,
                    size: 25,
                  ),
                ),
              ),
            ),
          ),
        ],
      );

  void initialComponents(var obj) {
    emailController.text = obj.userProfile!.email;
    phoneController.text = obj.userProfile!.phone;
    passwordController.text = obj.userProfile!.password;
    firstNameController.text = obj.userProfile!.name!.firstname;
    lastNameController.text = obj.userProfile!.name!.lastname;
    userNameController.text = obj.userProfile!.username;
  }

  void askPermission(context) {
    Provider.of<HomeProvider>(context, listen: false).requestPermission();
  }
}
