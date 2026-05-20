import 'package:flutter/material.dart';

class BiddingListing {
  const BiddingListing({
    required this.title,
    required this.description,
    required this.budget,
    required this.deadline,
    required this.bidsReceived,
    required this.category,
    required this.status,
    required this.isClosed,
  });

  final String title;
  final String description;
  final String budget;
  final String deadline;
  final int bidsReceived;
  final String category;
  final String status;
  final bool isClosed;
}

class BiddingCard extends StatelessWidget {
  const BiddingCard({
    super.key,
    required this.listing,
    required this.animationDelay,
  });

  final BiddingListing listing;
  final int animationDelay;

  @override
  Widget build(BuildContext context) {
    final BiddingListing listing = this.listing;
    final bool isClosed = listing.isClosed;
    final Color statusColor = isClosed
        ? const Color(0xFFB08968)
        : const Color(0xFF4F7D5F);

    // Simple and clean card design
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFE4EAF1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Text(
                    listing.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: const Color(0xFF111827),
                          fontWeight: FontWeight.w700,
                          height: 1.15,
                        ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: statusColor.withOpacity(0.22)),
                  ),
                  child: Text(
                    listing.status,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              listing.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF64748B),
                    height: 1.5,
                  ),
            ),
            const SizedBox(height: 14),
            Row(
              children: <Widget>[
                Text(
                  'Budget: ${listing.budget}',
                  style: const TextStyle(
                    color: Color(0xFF1F2937),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  'Deadline: ${listing.deadline}',
                  style: const TextStyle(
                    color: Color(0xFF1F2937),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              '${listing.bidsReceived} bids received',
              style: const TextStyle(
                color: Color(0xFF475569),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
