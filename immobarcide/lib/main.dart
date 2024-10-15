import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:immobarcide/firebase_options.dart';
import 'package:immobarcide/main2/models/scroll_offset.dart';
import 'package:immobarcide/screens/whole_page.dart';
import 'responsive.dart';
import 'scroll.dart';
import 'theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Immobarcide',
      initialRoute: '/',
      scrollBehavior: MyCustomScrollBeharvior(),
      debugShowCheckedModeBanner: false,
      theme: Responsive.isDesktop(context)
          ? TAppTheme.desktopTheme
          : TAppTheme.mobileTheme,
      home: BlocProvider(
        create: (_) => DisplayOffset(
          ScrollOffset(scrollOffsetValue: 0),
        ),
        child: WholePage(),
        // child: MyHomePage(),
      ),
    );
  }
}
