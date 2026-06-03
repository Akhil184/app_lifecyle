import 'package:flutter/material.dart';

class SecureHomePage extends StatefulWidget {
  const SecureHomePage({super.key});

  @override
  State<SecureHomePage> createState() => _SecureHomePageState();
}

class _SecureHomePageState extends State<SecureHomePage>
    with WidgetsBindingObserver {

  bool isLocked = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  // 🔐 REAL LIFE LIFECYCLE HANDLING
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {

    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {

      // App goes background → LOCK APP
      lockApp();
    }

    if (state == AppLifecycleState.resumed) {

      // App comes back → REQUIRE AUTH
      requireAuthentication();
    }
  }

  // 🔒 Lock app (real banking behaviour)
  void lockApp() {
    setState(() {
      isLocked = true;
    });
  }

  // 🔓 Unlock only after verification
  void requireAuthentication() async {

    // Example: simulate fingerprint / PIN check
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      isLocked = false;
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Secure Banking App")),
      body: isLocked ? buildLockScreen() : buildHome(),
    );
  }

  // 🔐 Lock Screen UI
  Widget buildLockScreen() {
    return const Center(
      child: Icon(
        Icons.lock,
        size: 100,
        color: Colors.red,
      ),
    );
  }

  // 🏠 Main App UI
  Widget buildHome() {
    return const Center(
      child: Icon(
        Icons.account_balance,
        size: 100,
        color: Colors.green,
      ),
    );
  }
}