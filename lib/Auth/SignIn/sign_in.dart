import 'package:amenda_cuts/Auth/SignUp/sign_up.dart';
import 'package:amenda_cuts/Common/Widget/Button/button.dart';
import 'package:amenda_cuts/Common/Widget/Containers/icon_container.dart';
import 'package:amenda_cuts/Common/Widget/Preloader/preloader.dart';
import 'package:amenda_cuts/Common/Widget/TextField/text_field.dart';
import 'package:amenda_cuts/Constants/color_constants.dart';
import 'package:amenda_cuts/Constants/new_app_background.dart';
import 'package:amenda_cuts/Constants/size_config.dart';
import 'package:amenda_cuts/Functions/Auth/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:email_validator/email_validator.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late bool obscure;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    obscure = true;
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double mWidth = SizeConfig.blockSizeWidth!;

    return NewAppBackground(
      color: ColorConstants.appBackground,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorConstants.appBackground,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: const AssetImage('assets/Logo/logo.png'),
                  width: mWidth * 50,
                ),
                const SizedBox(
                  height: 30,
                ),
                commonTextField(
                  controller: usernameController,
                  text: "Email",
                  maxLines: 1,
                  onChange: (value) {},
                  isPassword: false,
                  obscure: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    } else if (!EmailValidator.validate(value)) {
                      return 'Plaease enter a valid email';
                    }
                  },
                  icon: Iconsax.user,
                ),
                const SizedBox(
                  height: 30,
                ),
                commonTextField(
                  controller: passwordController,
                  text: "Password",
                  maxLines: 1,
                  onChange: (value) {},
                  isPassword: true,
                  obscure: obscure,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                  },
                  icon: Iconsax.lock,
                  onTap: () {
                    setState(() {
                      obscure = !obscure;
                    });
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                button(
                    color: ColorConstants.appColor,
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return Center(
                                child: SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: preloader(20.0),
                                ),
                              );
                            });
                        final email = usernameController.text.trim();
                        final password = passwordController.text.trim();
                        User? user = await Login.signInWithEmailAndPassword(
                            context,
                            email: email,
                            password: password);
                      }
                    },
                    text: 'Login'),
                const SizedBox(
                  height: 30,
                ),
                const Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: ColorConstants.blackBackground,
                        thickness: 2,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Or continue with",
                        style: TextStyle(color: ColorConstants.appTextColor),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: ColorConstants.blackBackground,
                        thickness: 2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    iconContainer(
                      width: mWidth * 12,
                      image: 'assets/Images/g.png',
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    iconContainer(
                      width: mWidth * 12,
                      image: 'assets/Images/f.png',
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    iconContainer(
                      width: mWidth * 12,
                      image: 'assets/Images/x.png',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "You Do Not Have An Account ?",
                        style: TextStyle(color: ColorConstants.appTextColor),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const SignUp()));
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            color: ColorConstants.appColor,
                          ),
                        ),
                      )
                    ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
