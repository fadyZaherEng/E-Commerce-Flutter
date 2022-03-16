// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_technical_task/adaptive/components_adaptive.dart';
import 'package:flutter_technical_task/modules/login/login_provider.dart';
import 'package:flutter_technical_task/shared/components/components.dart';
import 'package:flutter_technical_task/shared/components/constants.dart';
import 'package:flutter_technical_task/shared/network/local/cashe_helper.dart';
import 'package:flutter_technical_task/utils/ar.dart';
import 'package:flutter_technical_task/utils/en.dart';
import 'package:provider/provider.dart';

class LogInScreen extends StatefulWidget {
  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var phoneController = TextEditingController();
  var loginKey = GlobalKey<FormState>();
  var scafoldKey = GlobalKey<ScaffoldState>();

  var userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginProvider>(
      create: (context) => LoginProvider(),
      child: Scaffold(
        backgroundColor: SharedHelper.get(key: 'theme') == 'Light Theme'
            ? Colors.pink
            : Theme.of(context).scaffoldBackgroundColor,
        key: scafoldKey,
        body: Builder(builder: (context) {
          var obj = Provider.of<LoginProvider>(context, listen: true);
          return Center(
            child: Card(
              margin: const EdgeInsetsDirectional.all(15),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: loginKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (obj.logInMaterialButton !=
                            (SharedHelper.get(key: 'lang') == 'en'
                                ? en['LogIn']!
                                : ar['LogIn']!)
                        )
                          const SizedBox(
                            height: 20,
                          ),
                        if (obj.logInMaterialButton !=
                            (SharedHelper.get(key: 'lang') == 'en'
                                ? en['LogIn']!
                                : ar['LogIn']!))
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
                            },
                            onSubmitted: () {}),
                        const SizedBox(
                          height: 10,
                        ),
                        if (obj.logInMaterialButton !=
                            (SharedHelper.get(key: 'lang') == 'en'
                                ? en['LogIn']!
                                : ar['LogIn']!))
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
                              },
                              onSubmitted: () {}),
                        const SizedBox(
                          height: 20,
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
                              onSubmitted: () {}),
                        if (obj.logInMaterialButton !=
                            (SharedHelper.get(key: 'lang') == 'en'
                                ? en['LogIn']!
                                : ar['LogIn']!))
                          const SizedBox(
                            height: 10,
                          ),
                        if (obj.logInMaterialButton !=
                            (SharedHelper.get(key: 'lang') == 'en'
                                ? en['LogIn']!
                                : ar['LogIn']!))
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
                                    },
                                    onSubmitted: () {}),
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
                                    },
                                    onSubmitted: () {}),
                              ),
                            ],
                          ),
                        if (obj.logInMaterialButton !=
                            (SharedHelper.get(key: 'lang') == 'en'
                                ? en['LogIn']!
                                : ar['LogIn']!))
                          const SizedBox(
                            height: 10,
                          ),
                        defaultTextForm(
                          key: 'password',
                          context: context,
                          type: TextInputType.visiblePassword,
                          Controller: passwordController,
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.pink,
                          ),
                          suffixIcon: IconButton(
                              onPressed: () {
                                Provider.of<LoginProvider>(context,
                                    listen: false)
                                    .changeVisibilityOfEye();
                              },
                              icon: obj.suffixIcon),
                          text: SharedHelper.get(key: 'lang') == 'en'
                              ? en['Password']!
                              : ar['Password']!,
                          validate: (val) {
                            if (val.toString().isEmpty) {
                              return 'Password is Very Short';
                            }
                            return null;
                          },
                          obscure: obj.obscure,
                          onSubmitted: () {},
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Container(
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.pink,
                                borderRadius: BorderRadius.circular(20)),
                            child: obj.LoginLoadingStates
                                ? AdaptiveIndicator(getOs())
                                : MaterialButton(
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                if (loginKey.currentState!.validate() &&
                                    obj.logInMaterialButton ==
                                        (SharedHelper.get(key: 'lang') ==
                                            'en'
                                            ? en['LogIn']!
                                            : ar['LogIn']!)) {
                                  obj.LogIn(
                                      email: emailController.text.trim(),
                                      password:passwordController.text.trim(),
                                      context: context);
                                } else {
                                  if (loginKey.currentState!.validate()) {
                                    obj.signUp(
                                        email:
                                        emailController.text.trim(),
                                        password: passwordController.text
                                            .trim(),
                                        firstName: firstNameController
                                            .text
                                            .trim(),
                                        phone:
                                        phoneController.text.trim(),
                                        lastName: lastNameController.text
                                            .trim(),
                                        userName: userNameController.text
                                            .trim(),
                                        context: context);
                                  }
                                }
                              },
                              child: Text(
                                obj.logInMaterialButton,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Provider.of<LoginProvider>(context, listen: false)
                                .logInToggle();
                          },
                          child: Text(
                            obj.logInTextButton,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
