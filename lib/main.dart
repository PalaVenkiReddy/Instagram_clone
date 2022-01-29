import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter_firebase/providers/user_provider.dart';
import 'package:instagram_clone_flutter_firebase/responsive/mobile_screen.dart';
import 'package:instagram_clone_flutter_firebase/responsive/responsive_screen.dart';
import 'package:instagram_clone_flutter_firebase/responsive/web_screen.dart';
import 'package:instagram_clone_flutter_firebase/screens/welcome_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCnQHLSaUXEhBpqiJwd8y1fTraB8boQA3I",
            appId: "1:475312374828:web:689f9c887542b36eb43d89",
            messagingSenderId: "475312374828",
            projectId: "insta-flutter-ae01f",
            storageBucket: "insta-flutter-ae01f.appspot.com"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Instagram Clone with Firebase and Firestore',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: const Color.fromRGBO(0, 0, 0, 1),
            textSelectionTheme:
                TextSelectionThemeData(cursorColor: Colors.green[200])),
        //home: const MobileScreen(),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.idTokenChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return const ResponsiveScreen(
                      WebScreen: WebScreen(), MobileScreen: MobileScreen());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                }
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              }
              return const InitialScreen();
            }),
      ),
    );
  }
}
