import 'dart:convert';

import 'package:auction/features/home/models/bidding_listing.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/addbiddin.dart';
import '../pages/offer_point_home_screen.dart';
import '../../../../screens/splash_screen.dart';

class FragmentPlaceholder extends StatefulWidget {
  const FragmentPlaceholder({super.key});

  @override
  State<FragmentPlaceholder> createState() => _FragmentPlaceholderState();
}

class _FragmentPlaceholderState extends State<FragmentPlaceholder> {
  static const String _listingsStorageKey = 'bidding_listings';
  final List<BiddingListing> _listings = [];

  

  void _addListing(BiddingListing listing) {
    setState(() {
      _listings.add(listing);
    });
    _saveChanges();
  }

  void _removeListing(BiddingListing listing) {
    setState(() {
      _listings.removeWhere((item) => item.id == listing.id);
    });
    _saveChanges();
  }

  void _updateListing(BiddingListing updatedListing) {
    setState(() {
      final index =
          _listings.indexWhere((item) => item.id == updatedListing.id);
      if (index != -1) {
        _listings[index] = updatedListing;
      }
    });
    _saveChanges();
  }

  @override
  void initState() {
    super.initState();
    _loadListings();
  }

  Future<void> _saveChanges() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(
      _listings.map((listing) => listing.toJson()).toList(),
    );
    await prefs.setString(_listingsStorageKey, encoded);
  }

  Future<void> _loadListings() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = prefs.getString(_listingsStorageKey);
    if (encoded == null || encoded.isEmpty) {
      return;
    }

    final decoded = jsonDecode(encoded) as List<dynamic>;
    final loaded = decoded
        .map((item) => BiddingListing.fromJson(item as Map<String, dynamic>))
        .toList();

    setState(() {
      _listings
        ..clear()
        ..addAll(loaded);
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