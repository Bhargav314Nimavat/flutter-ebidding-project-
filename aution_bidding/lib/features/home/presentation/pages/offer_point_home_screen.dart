import 'dart:ui';

import 'package:auction/features/home/presentation/pages/addbiddin.dart';
import 'package:flutter/material.dart';

import '../widgets/bidding_card.dart';
import '../widgets/search_filter_bar.dart';

class OfferPointHomeScreen extends StatelessWidget {
  const OfferPointHomeScreen({super.key});

  // Static demo data keeps the screen fully local and deterministic for now.
  static const List<BiddingListing> _listings = <BiddingListing>[
    BiddingListing(
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
    BiddingListing(
      title: 'Bulk T-Shirt Printing',
      description:
          'Premium cotton shirts for a campaign launch with screen printing and fast delivery.',
      budget: 'AED 8,500',
      deadline: 'Due in 2 days',
      bidsReceived: 9,
      category: 'Printing',
      status: 'Open',
      isClosed: false,
    ),
    BiddingListing(
      title: 'Catering Service for Event',
      description:
          'Curated dining experience for 120 guests with canapés, live stations, and service staff.',
      budget: 'AED 22,000',
      deadline: 'Due tomorrow',
      bidsReceived: 16,
      category: 'Hospitality',
      status: 'Closed',
      isClosed: true,
    ),
    BiddingListing(
      title: 'Mobile App UI Design',
      description:
          'Luxury fintech interface concept with refined visual hierarchy and reusable design system.',
      budget: 'AED 14,500',
      deadline: 'Due in 6 days',
      bidsReceived: 7,
      category: 'Design',
      status: 'Open',
      isClosed: false,
    ),
    BiddingListing(
      title: 'Website Development',
      description:
          'Conversion-focused corporate website with responsive layouts, performance tuning, and CMS readiness.',
      budget: 'AED 35,000',
      deadline: 'Due in 8 days',
      bidsReceived: 21,
      category: 'Development',
      status: 'Open',
      isClosed: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Color(0xFFF8FAFC),
              Color(0xFFF2F4F8),
              Color(0xFFEDEFF5),
            ],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final double horizontalPadding =
                  constraints.maxWidth >= 1000 ? 48 : 20;

              return CustomScrollView(
                slivers: <Widget>[
                  // Top content keeps the title, CTA, and search area grouped together.
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding,
                      24,
                      horizontalPadding,
                      28,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Expanded(
                                child: _TitleSection(),
                              ),
                              const SizedBox(width: 16),
                              _AddBiddingButton(
                                onTap: () {},
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Live Requirements',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: const Color(0xFF17212F),
                                      fontWeight: FontWeight.w800,
                                    ),
                              ),
                              Text(
                                '${_listings.length} listings',
                                style: TextStyle(
                                  color: const Color(0xFF5D6878),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding,
                      0,
                      horizontalPadding,
                      28,
                    ),
                    // The list is built from static data using a scalable card widget.
                    sliver: SliverList.builder(
                      itemCount: _listings.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 18),
                          child: BiddingCard(
                            listing: _listings[index],
                            animationDelay: index * 90,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _TitleSection extends StatelessWidget {
  const _TitleSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'OfferPoint',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: const Color(0xFF111827),
                fontWeight: FontWeight.w800,
                letterSpacing: -1.2,
                height: 1.0,
              ),
        ),
        const SizedBox(height: 10),
        Text(
          'Find the best vendor offers instantly',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: const Color(0xFF617086),
                fontWeight: FontWeight.w400,
                height: 1.35,
              ),
        ),
      ],
    );
  }
}

class _AddBiddingButton extends StatelessWidget {
  const _AddBiddingButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(  
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddBidding())  
          );
        },
        borderRadius: BorderRadius.circular(8),
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Color(0xFF1F2733),
                Color(0xFF0F131A),
              ],
            ),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.white.withOpacity(0.08),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.add_rounded,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  'Add Bidding',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
