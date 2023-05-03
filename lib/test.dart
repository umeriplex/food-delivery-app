import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.2,
            color: Colors.red,
              child: const Center(
                child: Text(
                  '20%',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
          ),
          Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.8,
              color: Colors.green,
              child: const Center(
                child: Text(
                  '80%',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
          ),

        ],
      ),
    );
  }
}
