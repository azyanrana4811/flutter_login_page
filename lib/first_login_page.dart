import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_page/Login_page.dart';
import 'package:flutter_login_page/Signup_page.dart';

class FirstLoginPage extends StatefulWidget {
  FirstLoginPage({super.key});

  @override
  _FirstLoginPageState createState() => _FirstLoginPageState();
}

class _FirstLoginPageState extends State<FirstLoginPage>
    with TickerProviderStateMixin {
  void _showBottomSheet(BuildContext context, Widget pageContent) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        builder: (context, scrollController) => AnimatedContainer(
          duration: const Duration(seconds: 1),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 244, 245, 247),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(100),
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: pageContent,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedBackground(
        behaviour: RandomParticleBehaviour(
          options: const ParticleOptions(
              spawnMaxRadius: 60,
              particleCount: 12,
              spawnOpacity: 0.8,
              baseColor: Colors.blue,
              image: Image(image: AssetImage("assets/BgRmv.png"))),
        ),
        vsync: this,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                    height: 300,
                    width: 300,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/bgremove.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 70),
                ElevatedButton(
                  onPressed: () => _showBottomSheet(
                    context,
                    LoginPage(action: 'Login'), // Action parameter passed here
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                  ),
                  child: const Text('Login'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _showBottomSheet(
                    context,
                    SignUpPage(
                        action: 'Sign Up'), // Action parameter passed here
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                  ),
                  child: const Text('Sign Up'),
                ),
                const SizedBox(height: 30),
                const Row(
                  children: [
                    Expanded(
                      child: Divider(
                          thickness: 1,
                          indent: 40,
                          color: Color.fromARGB(255, 207, 206, 206)),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'or continue with',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        endIndent: 40,
                        color: Color.fromARGB(255, 207, 206, 206),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      // onTap: () async {
                      //   await signInWithFacebook();
                      // },
                      child: _buildSocialButton(Icons.facebook, Colors.blue),
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      // onTap: () async {
                      //   await signInWithGoogle();
                      // },
                      child: _buildSocialButton(Icons.g_mobiledata,
                          const Color.fromARGB(255, 240, 163, 159)),
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      // onTap: () async {
                      //   await signInWithApple();
                      // },
                      child: _buildSocialButton(
                          Icons.apple, const Color.fromARGB(255, 20, 20, 20)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildSocialButton(IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Icon(icon, color: color),
  );
}
