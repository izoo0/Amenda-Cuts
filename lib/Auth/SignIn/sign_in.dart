import 'package:amenda_cuts/Auth/SignUp/sign_up.dart';
import 'package:amenda_cuts/Common/Widget/Button/button.dart';
import 'package:amenda_cuts/Common/Widget/Containers/icon_container.dart';
import 'package:amenda_cuts/Common/Widget/Preloader/preloader.dart';
import 'package:amenda_cuts/Common/Widget/TextField/text_field.dart';
import 'package:amenda_cuts/Common/Constants/new_app_background.dart';
import 'package:amenda_cuts/Common/Constants/size_config.dart';
import 'package:amenda_cuts/Functions/Auth/login/login.dart';
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
    double mHeight = SizeConfig.blockSizeHeight!;

    return NewAppBackground(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
            child: Container(
              constraints: BoxConstraints(minHeight: mHeight * 100),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image(
                        image: Theme.of(context).brightness == Brightness.dark
                            ? const AssetImage('assets/Logo/logo.png')
                            : const AssetImage('assets/Logo/logo_light.jpg'),
                        width: mWidth * 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    commonTextField(
                      isPrefix: true,
                      context: context,
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
                          return 'Please enter a valid email';
                        }
                      },
                      icon: Iconsax.user,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    commonTextField(
                      isPrefix: true,
                      context: context,
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
                        context: context,
                        color: Theme.of(context).primaryColor,
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return Center(
                                    child: SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: preloader(20.0, context),
                                    ),
                                  );
                                });
                            final email = usernameController.text.trim();
                            final password = passwordController.text.trim();
                            await Login.signInWithEmailAndPassword(context,
                                email: email, password: password);
                          }
                        },
                        text: 'Login'),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Theme.of(context).dividerColor,
                            thickness: 2,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "Or continue with",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Theme.of(context).dividerColor,
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
                    Container(
                      width: mWidth * 90,
                      constraints: BoxConstraints(
                        maxHeight: mWidth * 90,
                      ),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("You Do Not Have An Account ?",
                                style: Theme.of(context).textTheme.bodyLarge),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => const SignUp()));
                              },
                              child: Text(" Sign Up",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .apply(
                                          color:
                                              Theme.of(context).primaryColor)),
                            )
                          ]),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
