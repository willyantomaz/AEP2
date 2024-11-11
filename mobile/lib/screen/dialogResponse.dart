import 'package:flutter/material.dart';

class Dialogresponse extends StatefulWidget {
  final String response;

  const Dialogresponse({super.key, required this.response});

  @override
  State<Dialogresponse> createState() => _DialogresponseState();
}

class _DialogresponseState extends State<Dialogresponse> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 200,
        height: 200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Força da senha:"),
              Text(widget.response),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Ok'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
