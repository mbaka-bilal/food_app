import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/onboarding/splash_screen.dart';
import 'services/cart.dart';
import 'services/f_auth.dart';
import 'services/f_coupon.dart';
import 'services/f_database.dart';
import 'services/f_payment.dart';
import 'services/show_all.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FAuth()),
        ChangeNotifierProvider(create: (context) => FDatabase()),
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProvider(create: (context) => FCoupon()),
        ChangeNotifierProvider(create: ((context) => FPayment())),
        ChangeNotifierProvider(create: ((context) => ShowAll())),
      ],
      child: MaterialApp(
        title: 'Elliott kitchen',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
