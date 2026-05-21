import 'package:flutter/foundation.dart';
import '../models/bidding_listing.dart';
import 'widgets/bidding_card.dart';

class BiddingManager extends ChangeNotifier {
  BiddingManager._internal();
  static final BiddingManager _instance = BiddingManager._internal();
  factory BiddingManager() => _instance;

  final List<BiddingListing> _listings = [
    const BiddingListing(
      id: '1',
      title: 'Office Interior Design',
      description:
          'Modern workspace revamp for a growing tech team with modular zones and warm materials.',
      budget: 'AED 48,000',
      deadline: 'Due in 4 days',
      bidsReceived: 12,
      category: 'Interior',
      status: 'Open',
      isClosed: false,
    ),
  ];

  List<BiddingListing> get listings => List.unmodifiable(_listings);

  void addListing(BiddingListing listing) {
    _listings.insert(0, listing);
    notifyListeners();
  }

  void updateListing(BiddingListing updatedListing) {
    final index = _listings.indexWhere((element) => element.id == updatedListing.id);
    if (index != -1) {
      _listings[index] = updatedListing;
      notifyListeners();
    }
  }

  void deleteListing(String id) {
    _listings.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}