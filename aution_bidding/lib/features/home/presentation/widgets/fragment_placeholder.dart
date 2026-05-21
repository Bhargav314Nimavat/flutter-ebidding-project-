import 'package:auction/features/home/models/bidding_listing.dart';
import 'package:flutter/material.dart';
import '../pages/addbiddin.dart';
import '../pages/offer_point_home_screen.dart';
import '../../../../screens/splash_screen.dart';

class FragmentPlaceholder extends StatefulWidget {
  const FragmentPlaceholder({super.key});

  @override
  State<FragmentPlaceholder> createState() => _FragmentPlaceholderState();
}

class _FragmentPlaceholderState extends State<FragmentPlaceholder> {
  final List<BiddingListing> _listings = [];

  void _addListing(BiddingListing listing) {
    setState(() {
      _listings.add(listing);
    });
  }

  void _removeListing(BiddingListing listing) {
    setState(() {
      _listings.removeWhere((item) => item.id == listing.id);
    });
  }

  void _updateListing(BiddingListing updatedListing) {
    setState(() {
      final index =
          _listings.indexWhere((item) => item.id == updatedListing.id);
      if (index != -1) {
        _listings[index] = updatedListing;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              builder: (context) => const SplashScreen(),
            );

          case '/homescreen':
            return MaterialPageRoute(
              builder: (context) => OfferPointHomeScreen(
                listings: _listings,
                onAdd: _addListing,
                onRemove: _removeListing,
                onUpdate: _updateListing,
              ),
            );

          case '/addbidding':
            final listingToEdit = settings.arguments as BiddingListing?;
            return MaterialPageRoute(
              builder: (context) => AddBidding(
                listingToEdit: listingToEdit,
                onAdd: _addListing,
                onUpdate: _updateListing,
              ),
            );

          default:
            return null;
        }
      },
    );
  }
}