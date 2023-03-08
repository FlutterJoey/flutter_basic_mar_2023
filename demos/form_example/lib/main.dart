import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}

class LoginFormData {
  String? password;
  String? email;

  void clear() {
    password = null;
    email = null;
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final LoginFormData _formData = LoginFormData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text('Email'),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail,
                onSaved: _saveEmail,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: const InputDecoration(
                  label: Text('Password'),
                ),
                onSaved: _savePassword,
                validator: _validatePassword,
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  void _savePassword(value) {
    _formData.password = value;
  }

  void _saveEmail(value) {
    _formData.email = value;
  }

  String? _validateEmail(value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    return null;
  }

  String? _validatePassword(value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 4) {
      return 'Password must be at least 4 characters';
    }
    return null;
  }

  void _submitForm() async {
    _formData.clear();
    var form = _formKey.currentState!;
    if (form.validate()) {
      form.save();
      if (await login(_formData.email!, _formData.password!)) {
        if (context.mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      }
      form.reset();
    }
  }

  Future<bool> login(String email, String password) async {
    await Future.delayed(Duration.zero);
    return true;
  }
}
