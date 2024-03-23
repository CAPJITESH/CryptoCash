import 'package:blockchain_upi/http/http.dart';
import 'package:blockchain_upi/widgets/textbox.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _acc1 = TextEditingController();
  final TextEditingController _acc2 = TextEditingController();
  final TextEditingController _p1 = TextEditingController();
  final TextEditingController _eth = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextBox(
                controller: _acc1,
                hinttext: "Account 1",
                label: "",
                obscureText: false,
              ),
              const SizedBox(
                height: 20,
              ),
              TextBox(
                controller: _p1,
                hinttext: "Private key 1",
                label: "",
                obscureText: false,
              ),
              const SizedBox(
                height: 20,
              ),
              TextBox(
                controller: _acc2,
                hinttext: "Account 2",
                label: "",
                obscureText: false,
              ),
              const SizedBox(
                height: 20,
              ),
              TextBox(
                controller: _eth,
                hinttext: "Ether",
                label: "",
                obscureText: false,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  final d = await HttpApiCalls().sendEther({
                    'acc1': _acc1.text,
                    "acc2": _acc2.text,
                    "p1": _p1.text,
                    'eth': _eth.text,
                  });
                },
                child: const Text("Transfer"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
