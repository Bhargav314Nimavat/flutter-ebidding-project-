<<<<<<< HEAD
import 'package:flutter/material.dart';
import '../pages/addbiddin.dart';
import '../pages/offer_point_home_screen.dart';

class FragmentPlaceholder extends StatefulWidget {
  const FragmentPlaceholder({super.key});

  @override
  State<FragmentPlaceholder> createState() => _FragmentPlaceholderState();
}

class _FragmentPlaceholderState extends State<FragmentPlaceholder> {
  @override
  Widget build(BuildContext context) {
    return  Navigator(
      onGenerateRoute: (settings) {
        switch(settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) => const OfferPointHomeScreen());

          case '/addbidding':
            return MaterialPageRoute(builder: (context) => const AddBidding());
          default:
            return null;
        }
      },
    );
  }
}
=======
import 'package:flutter/material.dart';
import '../pages/addbiddin.dart';
import '../pages/offer_point_home_screen.dart';

class FragmentPlaceholder extends StatelessWidget {
  const FragmentPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              builder: (context) => const OfferPointHomeScreen(),
            );

          case '/addbidding':
            return MaterialPageRoute(
              builder: (context) => const AddBidding(),
            );
          default:
            return null;
        }
      },
    );
  }
}
>>>>>>> 1ee7ac50d07585c8195261b9408624f48003b329
