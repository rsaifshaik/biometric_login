import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isAuthenticating = false;

  Future<void> _authenticate() async {
    bool authenticated = false;
    setState(() => _isAuthenticating = true);

    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Scan your fingerprint to login',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      debugPrint('Biometric error: $e');
    }

    setState(() => _isAuthenticating = false);

    if (authenticated) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    }
  }

  void _loginWithEmail() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      await secureStorage.write(key: 'token', value: 'dummy_token');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter both email and password")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "Welcome",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text("Login to continue",style: TextStyle(color: Colors.grey[700],fontSize: 20,fontWeight: FontWeight.w600),),
                const SizedBox(height: 30),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.black), // active border color
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey), // default border color
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration:  InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.black), // active border color
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey), // default border color
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: Size(420, 50)
                  ),
                    onPressed: _loginWithEmail, 
                    child: Text("Login with Email",style: TextStyle(color: Colors.white,fontSize: 18),),
                ),
                const SizedBox(height: 20),
                const Text("OR"),
                const SizedBox(height: 10),
                _isAuthenticating
                    ? const CircularProgressIndicator()
                    : IconButton(
                  icon: Icon(Icons.fingerprint, size: 60,color: Colors.grey[700],),
                  onPressed: _authenticate,
                ),
                const SizedBox(height: 10),
                Text("Use your fingerprint to login",style: TextStyle(color: Colors.grey[700],fontSize: 16),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
