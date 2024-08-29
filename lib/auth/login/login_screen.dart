import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/auth/register/register_screen.dart';
import 'package:todo_list/dialog_utils.dart';
import 'package:todo_list/firebase_function.dart';
import 'package:todo_list/home/app_colors.dart';
import 'package:todo_list/home/home_screen.dart';

import '../../provider/auth_user_Provider.dart';
import '../register/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'Login_screen';

  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
            title: Text('Login'),
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Welcome Back! ',
                    style: Theme.of(context).textTheme.titleMedium,),
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: (){
                      login();
                    },
                        child: Text('Login',
                        style: Theme.of(context).textTheme.titleMedium,)),
                  ),
                  TextButton(onPressed: (){
                    Navigator.of(context).pushNamed(RegisterScreen.routeName);

                  }, child: Text('OR Create Account',
                  style: Theme.of(context).textTheme.bodyMedium,))
                ],
              ),
            ),
          ),
        ),

      ],
    );
  }

  void login() async{
    if(formKey.currentState?.validate() == true){
      // login
      DialogUtils.showMessage(
          context: context,
          message: 'Loading...');
      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        var user = await FirebaseFunction.readUserFromFireStore(credential.user?.uid??'');
        if(user == null){
          return ;
        }
        var authProvider = Provider.of<AuthUserProvider>(context, listen: false);
        authProvider.updateUser(user);
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(context: context,
            message: 'Login Successfully. ',title: 'Success',
            posActionName: 'OK',
            posAction: (){
             Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            } );
        print(credential.user?.uid??"");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context: context,
              title: 'Error',
              posActionName: 'OK',
              message: 'The supplied auth credential is incorrect. ');
          print('The supplied auth credential is incorrect, malformed or has expired.');
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
      }catch(e){
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(context: context,
            title: 'Error',
            posActionName: 'OK',
            message: e.toString());
        print(e.toString());
      }
    }
  }
}
