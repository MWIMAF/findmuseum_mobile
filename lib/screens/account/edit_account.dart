import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:findmuseum_mobile/config.dart';
import 'package:findmuseum_mobile/models/edit_user_request_model.dart';
import 'package:findmuseum_mobile/services/api_service.dart';

class EditAccountPage extends StatefulWidget {
  final int id;
  final String name;
  final String username;
  final String email;

  EditAccountPage({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
  });

  @override
  State<EditAccountPage> createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  bool isApiCallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? name;
  String? username;
  String? email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Edit Account"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            ProgressHUD(
              inAsyncCall: isApiCallProcess,
              opacity: 0.3,
              key: UniqueKey(),
              child: Form(
                key: globalFormKey,
                child: _editAccountUI(context),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _editAccountUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormHelper.inputFieldWidget(
            context,
            "name",
            "New name",
            (onValidateVal) {
              if (onValidateVal == null && onValidateVal.isEmpty) {
                return "Name Can\t be Empty";
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
            "email",
            "New email",
            (onValidateVal) {
              if (onValidateVal == null && onValidateVal.isEmpty) {
                return "Schedule Can\t be Empty";
              }
              return null;
            },
            (onSavedVal) {
              email = onSavedVal;
            },
            prefixIcon: const Icon(Icons.mail),
            showPrefixIcon: true,
            borderColor: Theme.of(context).primaryColor,
            prefixIconColor: Theme.of(context).primaryColor,
            borderFocusColor: Theme.of(context).accentColor,
          ),
          const SizedBox(
            height: 20.0,
          ),
          FormHelper.inputFieldWidget(
            context,
            "username",
            "New username",
            (onValidateVal) {
              if (onValidateVal == null && onValidateVal.isEmpty) {
                return "username Can\t be Empty";
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
            height: 20.0,
          ),
          const SizedBox(
            height: 20.0,
          ),
          Center(
            child: FormHelper.submitButton(
              "Submit",
              () {
                if (validateAndSave()) {
                  setState(() {
                    isApiCallProcess = false;
                  });
                  EditUserRequestModel model = EditUserRequestModel(
                    name: name!,
                    username: username!,
                    email: email!,
                  );

                  APIService.updateUser(model, widget.id).then((response) => {
                        setState(() {
                          isApiCallProcess = false;
                        }),
                        if (response)
                          {
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/', (route) => false),
                          }
                        else
                          {
                            FormHelper.showSimpleAlertDialog(
                                context,
                                Config.appName,
                                "Please fill all form",
                                "OK", () {
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
            height: 20.0,
          ),
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
