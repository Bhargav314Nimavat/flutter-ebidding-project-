import 'package:auction/features/home/presentation/widgets/bidding_card.dart';
import 'package:auction/features/home/presentation/bidding_manager.dart';
import 'package:flutter/material.dart';

class AddBidding extends StatefulWidget {
  final BiddingListing? listingToEdit;

  const AddBidding({super.key, this.listingToEdit});

  @override
  State<AddBidding> createState() => _AddBiddingState();
}

class _AddBiddingState extends State<AddBidding> {
  /// CONTROLLERS
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();
  final TextEditingController deadlineController = TextEditingController();
  final TextEditingController bidsReceivedController = TextEditingController();

  /// DROPDOWN VALUES
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
      deadlineController.text = days != null ? days.toString() : item.deadline;
      
      bidsReceivedController.text = item.bidsReceived.toString();
      category = item.category;
      status = item.status;
      isClosed = item.isClosed;
    }
  }

  int? _extractDays(String deadline) {
    final regExp = RegExp(r'Due in (\d+) days');
    final match = regExp.firstMatch(deadline);
    if (match != null) {
      return int.tryParse(match.group(1) ?? '');
    }
    if (deadline.toLowerCase().contains('tomorrow')) {
      return 1;
    }
    if (deadline.toLowerCase().contains('today')) {
      return 0;
    }
    // Check if the whole string is just a number
    final rawNumberMatch = RegExp(r'^\d+$').firstMatch(deadline.trim());
    if (rawNumberMatch != null) {
      return int.tryParse(deadline.trim());
    }
    return null;
  }

  String _formatDeadline(int days) {
    if (days == 0) {
      return "Due today";
    }
    if (days == 1) {
      return "Due tomorrow";
    }
    final targetDate = DateTime.now().add(Duration(days: days));
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return "Due in $days days (${targetDate.day} ${months[targetDate.month - 1]})";
  }



  /// COMMON TEXTFIELD
  Widget customTextField({
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

            /// TITLE
            customTextField(
              label: "Title",
              controller: titleController,
            ),

            /// DESCRIPTION
            customTextField(
              label: "Description",
              controller: descriptionController,
              maxLines: 4,
            ),

            /// BUDGET
            customTextField(
              label: "Budget",
              controller: budgetController,
              keyboardType: TextInputType.number,
            ),

            /// DEADLINE
            customTextField(
              label: "Deadline (Number of Days)",
              controller: deadlineController,
              keyboardType: TextInputType.number,
            ),

            /// BIDS RECEIVED
            customTextField(
              label: "Bids Received",
              controller: bidsReceivedController,
              keyboardType: TextInputType.number,
            ),

            /// CATEGORY
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
                "Home Loan",
                "Mortgage",
                "Property",
                "Interior",
                "Printing",
                "Hospitality",
                "Design",
                "Development",
                if (![
                  "Home Loan",
                  "Mortgage",
                  "Property",
                  "Interior",
                  "Printing",
                  "Hospitality",
                  "Design",
                  "Development"
                ].contains(category))
                  category,
              ].map((String val) {
                return DropdownMenuItem<String>(
                  value: val,
                  child: Text(val),
                );
              }).toList(),

              onChanged: (value) {
                setState(() {
                  category = value!;
                });
              },
            ),

            const SizedBox(height: 15),

            /// STATUS
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
                "Open",
                "Pending",
                "Closed",
                if (!["Open", "Pending", "Closed"].contains(status))
                  status,
              ].map((String val) {
                return DropdownMenuItem<String>(
                  value: val,
                  child: Text(val),
                );
              }).toList(),

              onChanged: (value) {
                setState(() {
                  status = value!;
                });
              },
            ),

            const SizedBox(height: 15),

            /// SWITCH
            SwitchListTile(
              title: const Text("Is Closed"),
              value: isClosed,

              onChanged: (value) {
                setState(() {
                  isClosed = value;
                });
              },
            ),

            const SizedBox(height: 20),

            /// BUTTON
            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton(
                onPressed: () {
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

                  if (isEditing) {
                    /// UPDATE EXISTING OBJECT
                    final updatedBid = BiddingListing(
                      id: widget.listingToEdit!.id,
                      title: titleController.text,
                      description: descriptionController.text,
                      budget: budgetController.text,
                      deadline: deadlineStr,
                      bidsReceived: int.tryParse(bidsReceivedController.text) ?? widget.listingToEdit!.bidsReceived,
                      category: category,
                      status: status,
                      isClosed: isClosed,
                    );

                    BiddingManager().updateListing(updatedBid);
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Bidding listing updated successfully.')),
                    );
                  } else {
                    /// CREATE NEW OBJECT
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

                    BiddingManager().addListing(newBid);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Bidding listing created successfully.')),
                    );
                  }

                  /// BACK TO PREVIOUS PAGE
                  Navigator.pop(context);
                },

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