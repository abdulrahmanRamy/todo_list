import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/dialog_utils.dart';
import 'package:todo_list/firebase_function.dart';
import 'package:todo_list/home/app_colors.dart';
import 'package:todo_list/model/my_user.dart';
import 'package:todo_list/provider/auth_user_Provider.dart';

import '../../home/home_screen.dart';
import 'custom_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register_screen';

   RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  late AuthUserProvider authProvider;

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthUserProvider>(context);
    return Stack(
      children: [
        Container(
          color: AppColors.backGroundLightColor,
          child: Image.asset('assets/images/background.png',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('Create Account'),
            elevation: 0,
            backgroundColor: Colors.transparent,
            centerTitle: true,
          ),
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.3,),
                  CustomTextFormField(label: 'User Name',
                    controller: nameController,
                    Validator:(text){
                    if(text == null || text.trim().isEmpty){
                      return 'Please enter User Name.';
                    }
                    return null;
                    },
                  ),
                  CustomTextFormField(label: 'Email',
                    controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      Validator:(text){
                        if(text == null || text.trim().isEmpty){
                          return 'Please enter Email.';
                        }
                        final bool emailValid =
                        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(text);
                        if(!emailValid){
                          return 'Please enter valid email.';
                        }
                        return null;
                      }

                    ),
                  CustomTextFormField(label: 'Password',
                    keyboardType: TextInputType.number,
                    controller: passwordController,
                    obscureText: true,
                    Validator:(text){
                      if(text == null || text.trim().isEmpty){
                        return 'Please enter Password.';
                      }
                      if(text.length < 6){
                        return 'Password should at least 6 chars';
                      }
                      return null;
                    },
                  ),
                  CustomTextFormField(label: 'Confirm Password',
                    controller: confirmPasswordController,
                    keyboardType: TextInputType.phone,
                    obscureText: true,
                    Validator:(text){
                      if(text == null || text.trim().isEmpty){
                        return 'Please enter Confirm Password.';
                      }
                      if(text.length < 6){
                        return 'Password should at least 6 chars';
                      }
                      if(text != passwordController.text){
                        return "Confirm Password doesn't match Password";
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(onPressed: (){
                      register();
                    },
                        child: Text('Create Account',
                          style: Theme.of(context).textTheme.titleMedium,)),
                  )
                ],
              ),
            ),
          ),
        ),

      ],
    );
  }

  void register() async{
    if(formKey.currentState?.validate() == true){
      // register
      // show loading
      DialogUtils.showLoading(
          context: context,
          message: 'Loading...');
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        MyUser myUser = MyUser(
          id: credential.user?.uid ?? '',
          name: nameController.text,
          email: emailController.text
        );
        authProvider.updateUser(myUser);
        await FirebaseFunction.addUserToFireStore(myUser);
        // hide loading
        DialogUtils.hideLoading(context);
        // show message
        DialogUtils.showMessage(context: context,
            message: 'Register Successfully.', title: 'Success',
        posActionName: 'OK',
            posAction: ()
        {
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        });
        print(credential.user?.uid??"");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          // hide loading
          DialogUtils.hideLoading(context);
          // show message
          DialogUtils.showMessage(context: context,
              message: 'The password provided is too weak.', title: 'Error',
              posActionName: 'OK');
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          // hide loading
          DialogUtils.hideLoading(context);
          // show message
          DialogUtils.showMessage(context: context,
              posActionName: 'OK',
              message: 'The account already exists for that email.', title: 'Error');
          print('The account already exists for that email.');
        }
        else if (e.code == 'network-request-failed') {
          // hide loading
          DialogUtils.hideLoading(context);
          // show message
          DialogUtils.showMessage(context: context,
              posActionName: 'OK',
              message: 'A network error. ', title: 'Error');
          print('The account already exists for that email.');
        }
      } catch (e) {
        // hide loading
        DialogUtils.hideLoading(context);
        // show message
        DialogUtils.showMessage(context: context,
            message: e.toString(), title: 'Error',
            posActionName: 'OK');
        print(e);
      }
    }
  }
}
