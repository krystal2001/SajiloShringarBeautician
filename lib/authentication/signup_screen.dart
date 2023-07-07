// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// import 'package:sajiloshringar_app/authentication/login_screen.dart';

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({Key? key}) : super(key: key);

//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   final _formKey = GlobalKey<FormState>();

//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _usernameController = TextEditingController();
//   final _phonenoController = TextEditingController();

//   bool _isLoading = false;

//   Future<void> signUp() async {
//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       UserCredential userCredential =
//           await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: _emailController.text.trim(),
//         password: _passwordController.text.trim(),
//       );
//       String uid = userCredential.user!.uid;

//       Fluttertoast.showToast(
//         msg: 'Signup successful',
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         backgroundColor: Colors.green,
//         textColor: Colors.white,
//       );
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => LoginScreen()),
//       );
//       addUserDetails(
//         uid,
//         _usernameController.text.trim(),
//         _emailController.text.trim(),
//         _passwordController.text.trim(),
//         int.parse(_phonenoController.text.trim()),
//       );
//     } catch (e) {
//       if (e is FirebaseAuthException) {
//         print('Error: ${e.code} - ${e.message}');

//         String errorMessage = 'An error occurred';

//         switch (e.code) {
//           case 'email-already-in-use':
//             errorMessage =
//                 'The email address is already in use by another account';
//             break;
//           case 'invalid-email':
//             errorMessage = 'Invalid email address';
//             break;
//           case 'user-disabled':
//             errorMessage = 'This user account has been disabled';
//             break;
//           case 'user-not-found':
//             errorMessage = 'User not found';
//             break;
//           case 'wrong-password':
//             errorMessage = 'Invalid password';
//             break;
//         }

//         Fluttertoast.showToast(
//           msg: errorMessage,
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.CENTER,
//           timeInSecForIosWeb: 1,
//           backgroundColor: Colors.red,
//           textColor: Colors.white,
//         );
//       } else {
//         print('Error: $e');
//         // Handle other non-authentication related errors
//       }
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   Future<void> addUserDetails(String uid, String username, String email,
//       String password, int phoneno) async {
//     try {
//       CollectionReference users =
//           FirebaseFirestore.instance.collection('beautician');

//       await users.doc(uid).set({
//         'uid': uid,
//         'username': username,
//         'email': email,
//         'password': password,
//         'phoneno': phoneno,
//         'role': 'user',
//       });
//     } catch (e) {
//       print('Error storing user details: $e');
//     }
//   }

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     _usernameController.dispose();
//     _phonenoController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               const SizedBox(
//                 height: 10,
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Image.asset("images/logo1.png"),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 "Register as Beautician ",
//                 style: TextStyle(
//                   fontSize: 26,
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               TextField(
//                 controller: _usernameController,
//                 style: TextStyle(color: Colors.black),
//                 decoration: const InputDecoration(
//                   labelText: "Name",
//                   hintText: "Nisha Mahara",
//                   enabledBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: Colors.grey),
//                   ),
//                   focusedBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: Colors.grey),
//                   ),
//                   hintStyle: TextStyle(
//                     color: Colors.grey,
//                     fontSize: 10,
//                   ),
//                   labelStyle: TextStyle(
//                     color: Colors.black,
//                     fontSize: 16,
//                   ),
//                 ),
//               ),
//               TextField(
//                 controller: _emailController,
//                 style: TextStyle(color: Colors.black),
//                 decoration: const InputDecoration(
//                   labelText: "Email",
//                   hintText: "abc@gmail.com",
//                   enabledBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: Colors.grey),
//                   ),
//                   focusedBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: Colors.grey),
//                   ),
//                   hintStyle: TextStyle(
//                     color: Colors.grey,
//                     fontSize: 10,
//                   ),
//                   labelStyle: TextStyle(
//                     color: Colors.black,
//                     fontSize: 16,
//                   ),
//                 ),
//               ),
//               TextField(
//                 controller: _phonenoController,
//                 keyboardType: TextInputType.phone,
//                 style: TextStyle(color: Colors.black),
//                 decoration: const InputDecoration(
//                   labelText: "Phone",
//                   hintText: "9846111111",
//                   enabledBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: Colors.grey),
//                   ),
//                   focusedBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: Colors.grey),
//                   ),
//                   hintStyle: TextStyle(
//                     color: Colors.grey,
//                     fontSize: 10,
//                   ),
//                   labelStyle: TextStyle(
//                     color: Colors.black,
//                     fontSize: 16,
//                   ),
//                 ),
//               ),
//               TextField(
//                 controller: _passwordController,
//                 keyboardType: TextInputType.text,
//                 obscureText: true,
//                 style: TextStyle(color: Colors.black),
//                 decoration: const InputDecoration(
//                   labelText: "Password",
//                   hintText: "*********",
//                   enabledBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: Colors.grey),
//                   ),
//                   focusedBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: Colors.grey),
//                   ),
//                   hintStyle: TextStyle(
//                     color: Colors.grey,
//                     fontSize: 10,
//                   ),
//                   labelStyle: TextStyle(
//                     color: Colors.black,
//                     fontSize: 16,
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   signUp();
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.lightGreenAccent,
//                 ),
//                 child: const Text(
//                   "Create Account",
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 18,
//                   ),
//                 ),
//               ),
//               TextButton(
//                 child: const Text(
//                   "Already have an Account? Login Here",
//                   style: TextStyle(color: Colors.brown),
//                 ),
//                 onPressed: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (c) => LoginScreen()));
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
