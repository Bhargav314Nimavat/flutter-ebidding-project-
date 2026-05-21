import 'package:flutter/material.dart';
import '../../models/bidding_listing.dart';

class BiddingCard extends StatelessWidget {
  const BiddingCard({
    super.key,
    required this.listing,
    required this.animationDelay,
    required this.onEdit,
    required this.onDelete,
  });

  final BiddingListing listing;
  final int animationDelay;
  final void Function(BiddingListing) onEdit;
  final void Function(BiddingListing) onDelete;

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Delete Bidding?',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'Are you sure you want to delete this bidding requirement?',
            style: TextStyle(color: Color(0xFF64748B)),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog first
                onDelete(listing);      // Then call parent's delete
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Bidding listing deleted successfully.'),
                    backgroundColor: Colors.redAccent,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Delete',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isClosed = listing.isClosed;
    final Color statusColor =
        isClosed ? const Color(0xFFB08968) : const Color(0xFF4F7D5F);

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(
          color: Color(0xFFE4EAF1),
          width: 1,
        ),
      ),
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(18),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(6),
                    border:
                        Border.all(color: statusColor.withOpacity(0.22)),
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
            const SizedBox(height: 10),
            Text(
              listing.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF64748B),
                    height: 1.5,
                  ),
            ),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                Icon(
                  Icons.monetization_on_outlined,
                  size: 16,
                  color: Colors.blueGrey.shade600,
                ),
                const SizedBox(width: 6),
                Text(
                  'Budget: ${listing.budget}',
                  style: const TextStyle(
                    color: Color(0xFF1F2937),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 24),
                Icon(
                  Icons.access_time_outlined,
                  size: 16,
                  color: Colors.blueGrey.shade600,
                ),
                const SizedBox(width: 6),
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
            const Divider(color: Color(0xFFF1F5F9), height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.forum_outlined,
                      size: 16,
                      color: Colors.blueAccent.shade700,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${listing.bidsReceived} bids received',
                      style: TextStyle(
                        color: Colors.blueAccent.shade700,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Text(
                  listing.category,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(color: Color(0xFFF1F5F9), height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () => onEdit(listing),  // calls parent's onEdit
                  icon: const Icon(Icons.edit_outlined, size: 16),
                  label: const Text('Modify'),
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF1E293B),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
                const SizedBox(width: 12),
                TextButton.icon(
                  onPressed: () => _confirmDelete(context), // shows dialog, then calls parent's onDelete
                  icon: const Icon(Icons.delete_outline, size: 16),
                  label: const Text('Delete'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.redAccent,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}