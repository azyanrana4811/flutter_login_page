import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignUpPage extends StatefulWidget {
  final String action;

  const SignUpPage({super.key, required this.action});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final storage = FlutterSecureStorage(); // Use secure storage

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      await storage.write(key: 'email', value: emailController.text);
      await storage.write(key: 'password', value: passwordController.text);
      await storage.write(key: 'PhoneNumber', value: phoneController.text);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Successfully Submitted!"),
        ),
      );
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter an email";
    }

    RegExp emailRegExp =
        RegExp(r"^[a-zA-Z0-9._%+-]+@(gmail\.com|yahoo\.com|hotmail\.com)$");

    if (!emailRegExp.hasMatch(value)) {
      return "Enter a valid email";
    }

    return null;
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter a phone number";
    }
    RegExp digitRegExp = RegExp(r'^\d{11}$');
    if (!digitRegExp.hasMatch(value)) {
      return "Enter an 11-digit phone number consisting only of digits";
    }

    return null;
  }

  String? _validateUserName(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a username";
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please confirm your password";
    }
    if (value != passwordController.text) {
      return "Passwords do not match";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            const Text(
              'Create Your \nAccount',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: usernameController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: _validateUserName,
              decoration: InputDecoration(
                hintText: "Username",
                suffixIcon: const Icon(Icons.person_outline_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: phoneController,
              validator: _validatePhoneNumber,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                hintText: "PhoneNumber",
                suffixIcon: const Icon(Icons.call_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: emailController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: _validateEmail,
              decoration: InputDecoration(
                hintText: "Email",
                suffixIcon: const Icon(Icons.email_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              keyboardType: TextInputType.text,
              obscuringCharacter: "*",
              obscureText: !_isPasswordVisible,
              decoration: _buildInputDecoration(
                label: "Password",
                suffixIcon: Icons.visibility_off_outlined,
                suffixIconOnPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
                isPasswordVisible: _isPasswordVisible,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: confirmpasswordController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              obscureText: !_isConfirmPasswordVisible,
              validator: _validateConfirmPassword,
              obscuringCharacter: "*",
              decoration: _buildInputDecoration(
                label: 'Confirm Password',
                suffixIcon: Icons.visibility_off_outlined,
                suffixIconOnPressed: () {
                  setState(() {
                    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                  });
                },
                isPasswordVisible: _isConfirmPasswordVisible,
              ),
            ),
            const SizedBox(height: 30),
            FlutterPwValidator(
              controller: passwordController,
              minLength: 8,
              uppercaseCharCount: 1,
              lowercaseCharCount: 3,
              numericCharCount: 3,
              specialCharCount: 1,
              normalCharCount: 3,
              width: 400,
              height: 200,
              onSuccess: () {
                print("MATCHED");
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Password is matched")));
              },
              onFail: () {
                print("NOT MATCHED");
              },
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    required String label,
    required IconData suffixIcon,
    required VoidCallback suffixIconOnPressed,
    required bool isPasswordVisible,
  }) {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(30),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color.fromARGB(255, 46, 46, 46)),
        borderRadius: BorderRadius.circular(30),
      ),
      filled: true,
      labelText: label,
      suffixIcon: IconButton(
        icon: Icon(isPasswordVisible ? Icons.visibility : suffixIcon),
        onPressed: suffixIconOnPressed,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }
}
