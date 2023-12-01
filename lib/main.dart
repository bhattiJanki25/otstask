import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otstask/routes/Routes.dart';
import 'Screens/ProductListScreen.dart';
import 'bloc/ProductBloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes.onGenerateRouted,
      home: BlocProvider(
          create: (context) => ProductBloc(), child: ProductListingPage()),
    );
  }
}
