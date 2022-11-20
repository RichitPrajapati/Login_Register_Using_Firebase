import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'FireBase_Auth_Helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController signUpEmailController = TextEditingController();
  final TextEditingController signUpPasswordController =
  TextEditingController();

  String? email;
  String? password;

  String? firstName;
  String? lastName;
  String? signUpEmail;
  String? signUpPassword;

  bool isObscureText = true;
  bool isExistingAccount = true;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          child: Stack(
            alignment: Alignment.bottomCenter, //const Alignment(0, 0.2),
            children: [
              Column(
                children: [
                  ClipPath(
                    clipper: MyClipper(),
                    child: Container(
                      height: height * 0.5,
                      width: width,
                      color: Colors.red,
                      alignment: const Alignment(0, -14),
                      child: Image.asset("assets/images/logo-2.png"),
                    ),
                  ),
                  ClipPath(
                    clipper: MyClipper2(),
                    child: Container(
                      height: height * 0.5,
                      width: width ,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              (isExistingAccount)
                  ? Container(
                height: height * 0.65,
                child: Column(
                  children: [
                    Form(
                      key: loginFormKey,
                      child: Container(
                        width: width * 0.90,
                        height: height * 0.44,
                        padding:
                        const EdgeInsets.symmetric(horizontal: 24),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                              controller: emailController,
                              validator: (val) => (val!.isEmpty)
                                  ? "Please enter email...."
                                  : null,
                              onSaved: (val) {
                                setState(() {
                                  email = val;
                                });
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Email",
                                suffixIcon: Icon(Icons.person),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: passwordController,
                              validator: (val) => (val!.isEmpty)
                                  ? "Please enter password...."
                                  : null,
                              onSaved: (val) {
                                setState(() {
                                  password = val;
                                });
                              },
                              obscureText: isObscureText,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: "Password",
                                suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      isObscureText = !isObscureText;
                                    });
                                  },
                                  child: (isObscureText)
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility),
                                ),
                              ),
                            ),
                            const SizedBox(height: 28),
                            Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width *
                                  0.80,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (loginFormKey.currentState!
                                      .validate()) {
                                    loginFormKey.currentState!.save();

                                    User? user = await FirebaseAuthHelper
                                        .firebaseAuthHelper
                                        .signInWithEmailAndPassword(
                                        email: email!,
                                        password: password!);

                                    if (user != null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              "Successfully logged in..."),
                                        ),
                                      );

                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                          'home_page');
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                child: Text(
                                  "Sign In",
                                  style:
                                  GoogleFonts.poppins(fontSize: 18),selectionColor:Colors.red,
                                ),
                              ),
                              color: Colors.red,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "OR",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width *
                                  0.80,
                              child: ElevatedButton(
                                onPressed: () async {
                                  User? user = await FirebaseAuthHelper
                                      .firebaseAuthHelper
                                      .signInWithGoogle();

                                  if (user != null) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            "Successfully signed in with google..."),
                                        backgroundColor: Colors.green,
                                        behavior:
                                        SnackBarBehavior.floating,
                                      ),
                                    );

                                    Navigator.of(context)
                                        .pushReplacementNamed(
                                        'home_page');
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.red,
                                ),
                                child: Text(
                                  "Sign In With Google",
                                  style:
                                  GoogleFonts.poppins(fontSize: 18),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: 55,
                      width: width * 0.92,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.red),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              height: 52,
                              width: width * 0.45,
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      isExistingAccount = true;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: (isExistingAccount)
                                        ? Colors.white
                                        : Colors.red,
                                    foregroundColor: (isExistingAccount)
                                        ? Colors.red
                                        : Colors.white,
                                    textStyle: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  child:  Text("Existing",style: TextStyle(color: Colors.red),))),
                          Container(
                              height: 52,
                              width: width * 0.45,
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      isExistingAccount = false;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: (isExistingAccount)
                                        ? Colors.red
                                        : Colors.white,
                                    foregroundColor: (isExistingAccount)
                                        ? Colors.white
                                        : Colors.red,
                                    textStyle: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  child: const Text("New"))),
                        ],
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ) //SignIn
                  : Container(
                height: height * 0.65,
                child: Column(
                  children: [
                    Form(
                      key: signUpFormKey,
                      child: Container(
                        width: width * 0.90,
                        height: height * 0.44,
                        padding:
                        const EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            TextFormField(
                                controller: firstNameController,
                                onSaved: (val) {
                                  setState(() {
                                    firstName = val;
                                  });
                                },
                                validator: (val) => (val!.isEmpty)
                                    ? "Please enter first name"
                                    : null,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "First Name")),
                            const SizedBox(height: 14),
                            TextFormField(
                                controller: lastNameController,
                                onSaved: (val) {
                                  setState(() {
                                    lastName = val;
                                  });
                                },
                                validator: (val) => (val!.isEmpty)
                                    ? "Please enter last name"
                                    : null,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Last Name")),
                            const SizedBox(height: 14),
                            TextFormField(
                                controller: signUpEmailController,
                                onSaved: (val) {
                                  setState(() {
                                    signUpEmail = val;
                                  });
                                },
                                validator: (val) => (val!.isEmpty)
                                    ? "Please enter email..."
                                    : null,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Email")),
                            const SizedBox(height: 14),
                            TextFormField(
                                obscureText: isObscureText,
                                controller: signUpPasswordController,
                                onSaved: (val) {
                                  setState(() {
                                    signUpPassword = val;
                                  });
                                },
                                validator: (val) => (val!.isEmpty)
                                    ? "Please enter your password..."
                                    : (val.length < 6)
                                    ? "Password must be greater than 6 chars..."
                                    : null,
                                decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        setState(() {
                                          isObscureText = !isObscureText;
                                        });
                                      },
                                      child: (isObscureText)
                                          ? const Icon(
                                          Icons.visibility_off)
                                          : const Icon(Icons.visibility),
                                    ),
                                    labelText: "Password")),
                            const SizedBox(height: 22),
                            Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width *
                                  0.80,
                              color: Colors.red,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (signUpFormKey.currentState!
                                      .validate()) {
                                    signUpFormKey.currentState!.save();

                                    User? user = await FirebaseAuthHelper
                                        .firebaseAuthHelper
                                        .signUp(
                                        email: signUpEmail!,
                                        password: signUpPassword!);

                                    if (user != null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              "New User registered successfully..."),
                                          backgroundColor: Colors.green,
                                          behavior:
                                          SnackBarBehavior.floating,
                                        ),
                                      );
                                    }

                                    firstNameController.clear();
                                    lastNameController.clear();
                                    signUpEmailController.clear();
                                    signUpPasswordController.clear();

                                    setState(() {
                                      firstName = null;
                                      lastName = null;
                                      signUpEmail = null;
                                      signUpPassword = null;
                                    });
                                    SizedBox(height: 80);
                                  }
                                },
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                child: Text(
                                  "Sign Up",
                                  style:
                                  GoogleFonts.poppins(fontSize: 18),selectionColor: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: 55,
                      width: width * 0.92,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.red),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              height: 52,
                              width: width * 0.45,
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      isExistingAccount = true;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: (isExistingAccount)
                                        ? Colors.white
                                        : Colors.red,
                                    foregroundColor: (isExistingAccount)
                                        ? Colors.red
                                        : Colors.white,
                                    textStyle: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  child: const Text("Existing",style: TextStyle(color: Colors.white),))),
                          Container(
                              height: 52,
                              width: width * 0.45,
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      isExistingAccount = false;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: (isExistingAccount)
                                        ? Colors.red
                                        : Colors.white,
                                    foregroundColor: (isExistingAccount)
                                        ? Colors.white
                                        : Colors.red,
                                    textStyle: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  child: const Text("New",style: TextStyle(color: Colors.red),),)),
                        ],
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ), //SignUp
            ],
          ),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, size.height * 0.90);
    path.quadraticBezierTo(size.width * 0.20, size.height * 0.45,
        size.width * 0.5, size.height * 0.60);
    path.quadraticBezierTo(
        size.width * 0.70, size.height * 0.70, size.width, size.height * 0.25);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class MyClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, size.height * 0.75);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.40,
        size.width * 0.5, size.height * 0.55);
    path.quadraticBezierTo(
        size.width * 0.80, size.height * 0.75, size.width, size.height * 0.35);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
