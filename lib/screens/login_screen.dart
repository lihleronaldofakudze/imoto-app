import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:imoto/services/auth_service.dart';
import 'package:imoto/widgets/glass_container_widget.dart';
import 'package:imoto/widgets/loading_widget.dart';
import 'package:imoto/widgets/text_box_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return _loading
        ? const LoadingWidget()
        : Scaffold(
            backgroundColor: Colors.white,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              iconTheme: const IconThemeData(color: Colors.red),
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/makhenikha.jpg'),
                      fit: BoxFit.cover)),
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(
                        height: 80,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Welcome Back, Login.',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GlassContainerWidget(
                        height: 420,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const Text('Please enter all required details',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              TextBoxWidget(
                                  hintText: 'Email Address',
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  obscureText: false),
                              TextBoxWidget(
                                  hintText: 'Password',
                                  controller: _passwordController,
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true),
                              const SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/forgot_password');
                                  },
                                  child: const Text('Forgot Password?',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 45,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: ElevatedButton(
                                  onPressed: _login,
                                  child: Text(
                                    'Continue'.toUpperCase(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/register');
                                  },
                                  child: const Text('I don\'t have an account?',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  _login() async {
    setState(() {
      _loading = true;
    });
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      dynamic result = await AuthService().login(
          email: _emailController.text, password: _passwordController.text);

      if (result != null) {
        setState(() {
          _loading = false;
        });
        Navigator.pushNamed(context, '/auth');
      } else {
        setState(() {
          _loading = false;
        });
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.BOTTOMSLIDE,
          title: 'Login Failed',
          desc: 'Please check your credentials and try again.',
          btnOkOnPress: () {},
        ).show();
      }
    } else {
      setState(() {
        _loading = false;
      });
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.BOTTOMSLIDE,
        title: 'Login Failed',
        desc: 'Please check your credentials and try again.',
        btnOkOnPress: () {},
      ).show();
    }
  }
}
