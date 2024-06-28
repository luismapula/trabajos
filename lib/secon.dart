import 'package:flutter/material.dart';

class Homescreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 140,
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
                colors: [
                  Colors.teal.shade400,
                  Colors.teal.shade300,
                  Colors.teal.shade200
                ],
                stops: const [0.3, 0.7, 0.9],
              ),
            ),
          ),
          Center(
            child: Container(
              width: 350,
              height: 550,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  'Rectángulo en el centro',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                  
              ),
            ),
          ),
        ],
      ),
    );
  }
}
