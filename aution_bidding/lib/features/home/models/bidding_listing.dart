class BiddingListing {
  const BiddingListing({
    required this.id,
    required this.title,
    required this.description,
    required this.budget,
    required this.deadline,
    required this.bidsReceived,
    required this.category,
    required this.status,
    required this.isClosed,
  });

  final String id;
  final String title;
  final String description;
  final String budget;
  final String deadline;
  final int bidsReceived;
  final String category;
  final String status;
  final bool isClosed;
}
