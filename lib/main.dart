import 'package:flutter/material.dart';
import 'src/data/database_helper.dart'; // Asegúrate de importar correctamente tu archivo database_helper.dart
import 'secon.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _message = '';

  Future<void> _login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    DatabaseHelper dbHelper = DatabaseHelper();
    Map<String, dynamic>? user = await dbHelper.getUser(username, password);

    if (user != null) {
      setState(() {
        _message = 'Login successful';
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Homescreen()),
      );
    } else {
      setState(() {
        _message = 'Invalid credentials';
      });
    }
  }

  Future<void> _register() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    DatabaseHelper dbHelper = DatabaseHelper();
    await dbHelper.insertUser({'username': username, 'password': password});

    setState(() {
      _message = 'User registered';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 160,
        backgroundColor: Colors.teal.shade400,
        title: Image.asset(
          'assets/img/Logo.png', // ruta imagen
        ),
        centerTitle: true, // centra la imagen dentro del AppBar
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.teal.shade400,Colors.teal.shade700 , Colors.teal.shade900],
                stops: [0.3,0.7, 0.9],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 12.0),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _login,
                    child: Text('Login'),
                  ),
                  ElevatedButton(
                    onPressed: _register,
                    child: Text('Register'),
                  ),
                  SizedBox(height: 20),
                  Text(
                    _message,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}