import 'package:flutter/material.dart';

class RanaTry extends StatefulWidget {
  const RanaTry({super.key});

  @override
  State<RanaTry> createState() => _RanaTryState();
}

class _RanaTryState extends State<RanaTry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios),
        title: Text("HI t a Rana"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            TextField(
              decoration: InputDecoration(
                error: Text("jooo"),
                hintText: "wink wink",
                label: Text("roro type"),
              ),
            ),
            SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("CoCo Melon")));
                },
                child: Text("Click on me"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
