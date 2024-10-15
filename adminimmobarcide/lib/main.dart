import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';
import 'models/scroll_offset.dart';
import 'responsive.dart';
import 'screens/login/signIn.dart';
import 'screens/whole_profil_page.dart';
import 'scroll.dart';
import 'theme/theme.dart';

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

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
      title: 'Immobarcide Admin',
      //initialRoute: '/',
      scrollBehavior: MyCustomScrollBeharvior(),
      scaffoldMessengerKey: snackbarKey,
      debugShowCheckedModeBanner: false,
      theme: Responsive.isDesktop(context)
          ? TAppTheme.desktopTheme
          : TAppTheme.mobileTheme,
      //home: SignIn(),
      home: BlocProvider(
        create: (_) => DisplayOffset(
          ScrollOffset(scrollOffsetValue: 0),
        ),
        child: SignIn(),
        //child: WholeProfilPage(),
      ),
    );
  }
}
