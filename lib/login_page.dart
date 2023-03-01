

import 'package:firebase_app/home_page.dart';
import 'package:firebase_app/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formkey =GlobalKey<FormState>();
  var email ="";
  var password ="";
  String? errorMessage='';

  TextEditingController emailController =TextEditingController();
  TextEditingController passwordController =TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  submitform(String email, String password) async {
    final auth = FirebaseAuth.instance;
    print(email);

    UserCredential authResult;
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      });
    } catch (error) {
      print(error);
    }
  }






  // Future<void>signInWithEmailAndPassword() async{
  //   try{
  //     await Auth().signInWithEmailAndPassword(
  //       email: emailController.text,
  //       password: passwordController.text,
  //     );
  //   } on FirebaseAuthException catch (e){
  //     errorMessage=e.message;
  //   }
  // }
  //
  // Future<void>createUserWithEmailAndPassword() async{
  //   try{
  //     await Auth().createUserWithEmailAndPassword(
  //       email: emailController.text,
  //       password: passwordController.text,
  //     );
  //   } on FirebaseAuthException catch (e){
  //     errorMessage=e.message;
  //   }
  // }



  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Container(
            padding: EdgeInsets.symmetric( vertical: 120.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/lottie/loginnew.json'),

                SizedBox(height: 50.0),
                Padding(
                  padding: const EdgeInsets.only(left: 30,right: 30,top: 14,bottom: 8),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value){
                      if(value==null || value.isEmpty){
                        // SnackBar(content: Text("Please Enter Email",style: TextStyle(color: Colors.red),),);
                        return 'Please Enter Email';
                      }
                      else if(!value.contains('@walchandsangli.ac.in')){
                        return 'Please enter valid email';
                      }
                      return null;
                    },
                  ),
                ),
                // SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.only(left: 30,right: 30,top: 14,bottom: 14),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    controller: passwordController,
                    validator: (value){
                      if(value == null || value.isEmpty  ){
                        return 'Please Enter password';
                      }else if(value.length!<7)
                        return 'weak password';
                      return null;
                    },
                    obscureText: true,

                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(onPressed: (){
                  if(_formkey.currentState!.validate()){
                    setState(() {
                      submitform(emailController.text, passwordController.text);
                    });
                  }
                  else{
                    print("sumit");
                  }
                },
                  child: Text("Login"),
                  style: ElevatedButton.styleFrom(padding: EdgeInsets.only(left: 30,right: 30,top:14,bottom: 14),shape: StadiumBorder(),backgroundColor: Colors.teal[600]),
                ),
                SizedBox(height: 10,),
                InkWell(
                  child: Container(
                    child:
                    Text("Don't have an account ? Sign up"),
                  ),
                  onTap: (){
                    setState(() {
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>SignUp()));
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
