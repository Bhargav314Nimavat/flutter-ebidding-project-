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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'budget': budget,
      'deadline': deadline,
      'bidsReceived': bidsReceived,
      'category': category,
      'status': status,
      'isClosed': isClosed,
    };
  }

  factory BiddingListing.fromJson(Map<String, dynamic> json) {
    return BiddingListing(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      budget: json['budget'] as String,
      deadline: json['deadline'] as String,
      bidsReceived: json['bidsReceived'] as int,
      category: json['category'] as String,
      status: json['status'] as String,
      isClosed: json['isClosed'] as bool,
    );
  }
}
