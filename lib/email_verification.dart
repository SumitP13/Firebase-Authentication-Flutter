// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:firebase_app/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({Key? key, required this.email}) : super(key: key);

  final String email;

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}


class _EmailVerificationState extends State<EmailVerification> {

   bool isEmailVerified = false;
   bool canResendEmail = false;
   Timer? timer;

   User? user;

   @override
   void initState() {
     user = FirebaseAuth.instance.currentUser;
     super.initState();
     isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

     if (!isEmailVerified) {
       verifyEmail(context: context);
       timer = Timer.periodic(Duration(seconds: 3), (_) => checkEmailVerified());
     }
   }

   @override
   void dispose() {
     timer?.cancel();
     super.dispose();
   }

   Future checkEmailVerified() async {
     await FirebaseAuth.instance.currentUser!.reload();
     setState(() {
       isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
     });

     if (isEmailVerified) {
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
           backgroundColor: Colors.white,
           content: Text(
             'Email verified Successfully',
             style: TextStyle(color: Colors.black),
           ),
         ),
       );
       timer?.cancel();
     }
   }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(child: Text("Verify your Email")),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Lottie.asset("assets/lottie/loginnew.json",fit: BoxFit.cover),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Text(.email,style: TextStyle(color: Colors.black),),
                  Text(widget.email,style: TextStyle(color: Colors.red,),),
                  SizedBox(
                    height: 30,
                  ),

                  SizedBox(
                    height: 30.0,
                  ),
                  ElevatedButton(onPressed: () async{
                    // print("Sumit");
                  await verifyEmail(context :context);
                  },
                      child: Text("Verify Email"),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future verifyEmail({required context}) async {
  try {
    final user = FirebaseAuth.instance.currentUser!;
    await user.sendEmailVerification();
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Verification email has been sent',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user != null && user.emailVerified) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));// replace '/next_screen' with the route name of your next screen
      }
    });
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          e.toString(),
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}



//
// void initState() {
//   super.initState();
//   // Initialize the package
//   emailAuth = new EmailAuth(
//     sessionName: "Sample session",
//   );
//
//   /// Configuring the remote server
//   emailAuth.config(remoteServerConfiguration);
// }
//
// void sendOTP() async{
//   emailAuth = new EmailAuth(
//     sessionName: "Sample session",
//   );
//   bool res= await  emailAuth.sendOtp(  recipientMail: _emailController.text,otpLength: 6);
//   if(res)
//   {
//     print("OTP Sent");
//   }
//   else{
//     print("We could not sent the OTP");
//   }
// }
//
// void verifyOTP()async{
//   var res =emailAuth.validateOtp(recipientMail: _emailController.text,userOtp: _otpController.value.text
//   );
//   if(res){
//     print("OTP Verified");
//   }
//   else{
//     print("Invalid OTP");
//   }
// }