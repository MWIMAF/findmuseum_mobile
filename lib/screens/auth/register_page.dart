import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:findmuseum_mobile/models/register_request_model.dart';
import 'package:findmuseum_mobile/services/api_service.dart';
import 'package:findmuseum_mobile/config.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isApiCallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? name;
  String? email;
  String? password;
  String? username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: ProgressHUD(
          inAsyncCall: isApiCallProcess,
          opacity: 0.3,
          key: UniqueKey(),
          child: Form(
            key: globalFormKey,
            child: _registerUI(context),
          ),
        ),
      ),
    );
  }

  Widget _registerUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Colors.white],
              ),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 75.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 250,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Register Account",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  fontFamily: "Rubik",
                ),
              ),
            ),
          ),
          FormHelper.inputFieldWidget(
            context,
            "email",
            "Email",
            (onValidateVal) {
              if (onValidateVal == null && onValidateVal.isEmpty) {
                return "Email Can't be Empty";
              }
              return null;
            },
            (onSavedVal) {
              email = onSavedVal;
            },
            prefixIcon: const Icon(Icons.email),
            showPrefixIcon: true,
            borderColor: Theme.of(context).primaryColor,
            prefixIconColor: Theme.of(context).primaryColor,
            borderFocusColor: Theme.of(context).accentColor,
          ),
          const SizedBox(
            height: 15.0,
          ),
          FormHelper.inputFieldWidget(
            context,
            "password",
            "Password",
            (onValidateVal) {
              if (onValidateVal == null && onValidateVal.isEmpty) {
                return "Password Can't be Empty";
              }
              return null;
            },
            (onSavedVal) {
              password = onSavedVal;
            },
            prefixIcon: const Icon(Icons.key),
            showPrefixIcon: true,
            borderColor: Theme.of(context).primaryColor,
            prefixIconColor: Theme.of(context).primaryColor,
            borderFocusColor: Theme.of(context).accentColor,
            obscureText: hidePassword,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  hidePassword = !hidePassword;
                });
              },
              icon: Icon(
                hidePassword ? Icons.visibility_off : Icons.visibility,
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          FormHelper.inputFieldWidget(
            context,
            "name",
            "Full Name",
            (onValidateVal) {
              if (onValidateVal == null && onValidateVal.isEmpty) {
                return "Name Can't be Empty";
              }
              return null;
            },
            (onSavedVal) {
              name = onSavedVal;
            },
            prefixIcon: const Icon(Icons.person),
            showPrefixIcon: true,
            borderColor: Theme.of(context).primaryColor,
            prefixIconColor: Theme.of(context).primaryColor,
            borderFocusColor: Theme.of(context).accentColor,
          ),
          const SizedBox(
            height: 15.0,
          ),
          FormHelper.inputFieldWidget(
            context,
            "username",
            "Username",
            (onValidateVal) {
              if (onValidateVal == null && onValidateVal.isEmpty) {
                return "Username Can't be Empty";
              }
              return null;
            },
            (onSavedVal) {
              username = onSavedVal;
            },
            prefixIcon: const Icon(Icons.numbers),
            showPrefixIcon: true,
            borderColor: Theme.of(context).primaryColor,
            prefixIconColor: Theme.of(context).primaryColor,
            borderFocusColor: Theme.of(context).accentColor,
          ),
          const SizedBox(
            height: 15.0,
          ),
          const SizedBox(
            height: 15.0,
          ),
          Center(
            child: FormHelper.submitButton(
              "Register",
              () {
                if (validateAndSave()) {
                  setState(() {
                    isApiCallProcess = true;
                  });
                  RegisterRequestModel model = RegisterRequestModel(
                    name: name!,
                    username: username!,
                    email: email!,
                    password: password!,
                  );

                  APIService.register(model).then((response) => {
                        print("REG ${response.data}"),
                        setState(() {
                          isApiCallProcess = false;
                        }),
                        if (response.data != null)
                          {
                            FormHelper.showSimpleAlertDialog(
                              context,
                              Config.appName,
                              "Register Success, Please Login!",
                              "OK",
                              () {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  '/login',
                                  (route) => false,
                                );
                              },
                            )
                          }
                        else
                          {
                            FormHelper.showSimpleAlertDialog(
                                context, Config.appName, response.message, "OK",
                                () {
                              Navigator.pop(context);
                            })
                          }
                      });
                }
              },
              btnColor: Theme.of(context).primaryColor,
              borderColor: Theme.of(context).primaryColor,
              txtColor: Colors.white,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          // const Center(
          //   child: Text(
          //     "Already have an account?",
          //     style: TextStyle(
          //       fontWeight: FontWeight.normal,
          //     ),
          //   ),
          // ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: "Already have an account? Log in!",
                      style: const TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, '/login');
                        },
                    )
                  ],
                ),
                // text: "Don\t Have an Account?",
              ),
            ),
          )
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
