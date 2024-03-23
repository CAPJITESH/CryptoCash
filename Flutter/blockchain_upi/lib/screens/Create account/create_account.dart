import 'package:blockchain_upi/createWallet.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final nme = WalletProvider().generateMnemonic();
            final pri = await WalletProvider().getPrivateKey(nme);
            final pub = await WalletProvider().getPublicKey(pri);

            print("Mne : $nme");
            print("pri : $pri");
            print("Public : $pub");
          },
          child: const Text("Click"),
        ),
      ),
    );
  }
}
