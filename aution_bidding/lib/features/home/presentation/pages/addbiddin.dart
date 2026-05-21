import 'package:flutter/material.dart';
import '../../models/bidding_listing.dart';

// Stays StatefulWidget — it owns only local form state (controllers + dropdowns).
// All business logic (add/update) is delegated to callbacks from FragmentPlaceholder.
class AddBidding extends StatefulWidget {
  final BiddingListing? listingToEdit;
  final void Function(BiddingListing) onAdd;
  final void Function(BiddingListing) onUpdate;

  const AddBidding({
    super.key,
    this.listingToEdit,
    required this.onAdd,
    required this.onUpdate,
  });

  @override
  State<AddBidding> createState() => _AddBiddingState();
}

class _AddBiddingState extends State<AddBidding> {
  // Controllers and dropdown values are purely local UI state — correct here.
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();
  final TextEditingController deadlineController = TextEditingController();
  final TextEditingController bidsReceivedController = TextEditingController();

  String category = "Home Loan";
  String status = "Open";
  bool isClosed = false;

  @override
  void initState() {
    super.initState();
    if (widget.listingToEdit != null) {
      final item = widget.listingToEdit!;
      titleController.text = item.title;
      descriptionController.text = item.description;
      budgetController.text = item.budget;
      final days = _extractDays(item.deadline);
      deadlineController.text =
          days != null ? days.toString() : item.deadline;
      bidsReceivedController.text = item.bidsReceived.toString();
      category = item.category;
      status = item.status;
      isClosed = item.isClosed;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    budgetController.dispose();
    deadlineController.dispose();
    bidsReceivedController.dispose();
    super.dispose();
  }

  int? _extractDays(String deadline) {
    final regExp = RegExp(r'Due in (\d+) days');
    final match = regExp.firstMatch(deadline);
    if (match != null) return int.tryParse(match.group(1) ?? '');
    if (deadline.toLowerCase().contains('tomorrow')) return 1;
    if (deadline.toLowerCase().contains('today')) return 0;
    final rawNumberMatch = RegExp(r'^\d+$').firstMatch(deadline.trim());
    if (rawNumberMatch != null) return int.tryParse(deadline.trim());
    return null;
  }

  String _formatDeadline(int days) {
    if (days == 0) return "Due today";
    if (days == 1) return "Due tomorrow";
    final targetDate = DateTime.now().add(Duration(days: days));
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return "Due in $days days (${targetDate.day} ${months[targetDate.month - 1]})";
  }

  void _submit() {
    if (titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a title')),
      );
      return;
    }

    final daysInput = int.tryParse(deadlineController.text.trim());
    String deadlineStr = deadlineController.text.trim();
    if (daysInput != null) {
      deadlineStr = _formatDeadline(daysInput);
    } else if (deadlineStr.isEmpty) {
      deadlineStr = "Due today";
    }

    final isEditing = widget.listingToEdit != null;

    if (isEditing) {
      final updatedBid = BiddingListing(
        id: widget.listingToEdit!.id,
        title: titleController.text,
        description: descriptionController.text,
        budget: budgetController.text,
        deadline: deadlineStr,
        bidsReceived: int.tryParse(bidsReceivedController.text) ??
            widget.listingToEdit!.bidsReceived,
        category: category,
        status: status,
        isClosed: isClosed,
      );
      // Calls FragmentPlaceholder's _updateListing — no BiddingManager needed
      widget.onUpdate(updatedBid);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bidding listing updated successfully.')),
      );
    } else {
      final newBid = BiddingListing(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: titleController.text,
        description: descriptionController.text,
        budget: budgetController.text,
        deadline: deadlineStr,
        bidsReceived: int.tryParse(bidsReceivedController.text) ?? 0,
        category: category,
        status: status,
        isClosed: isClosed,
      );
      // Calls FragmentPlaceholder's _addListing — no BiddingManager needed
      widget.onAdd(newBid);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bidding listing created successfully.')),
      );
    }

    Navigator.pop(context);
  }

  Widget _customTextField({
    required String label,
    required TextEditingController controller,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.grey.shade100,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.listingToEdit != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Modify Bidding" : "Add Bidding"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _customTextField(label: "Title", controller: titleController),
            _customTextField(
              label: "Description",
              controller: descriptionController,
              maxLines: 4,
            ),
            _customTextField(
              label: "Budget",
              controller: budgetController,
              keyboardType: TextInputType.number,
            ),
            _customTextField(
              label: "Deadline (Number of Days)",
              controller: deadlineController,
              keyboardType: TextInputType.number,
            ),
            _customTextField(
              label: "Bids Received",
              controller: bidsReceivedController,
              keyboardType: TextInputType.number,
            ),

            /// CATEGORY DROPDOWN
            DropdownButtonFormField<String>(
              value: category,
              decoration: InputDecoration(
                labelText: "Category",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
              items: [
                "Home Loan", "Mortgage", "Property", "Interior",
                "Printing", "Hospitality", "Design", "Development",
                if (!["Home Loan", "Mortgage", "Property", "Interior",
                      "Printing", "Hospitality", "Design", "Development"]
                    .contains(category))
                  category,
              ].map((val) => DropdownMenuItem(value: val, child: Text(val)))
               .toList(),
              onChanged: (value) => setState(() => category = value!),
            ),

            const SizedBox(height: 15),

            /// STATUS DROPDOWN
            DropdownButtonFormField<String>(
              value: status,
              decoration: InputDecoration(
                labelText: "Status",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
              items: [
                "Open", "Pending", "Closed",
                if (!["Open", "Pending", "Closed"].contains(status)) status,
              ].map((val) => DropdownMenuItem(value: val, child: Text(val)))
               .toList(),
              onChanged: (value) => setState(() => status = value!),
            ),

            const SizedBox(height: 15),

            /// IS CLOSED SWITCH
            SwitchListTile(
              title: const Text("Is Closed"),
              value: isClosed,
              onChanged: (value) => setState(() => isClosed = value),
            ),

            const SizedBox(height: 20),

            /// SUBMIT BUTTON
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _submit,
                child: Text(
                  isEditing ? "Update Bidding" : "Add Bidding",
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}