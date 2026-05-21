import 'package:flutter/material.dart';
import 'package:auction/features/home/models/bidding_listing.dart';
import '../widgets/bidding_card.dart';

class OfferPointHomeScreen extends StatelessWidget {
  final List<BiddingListing> listings;
  final void Function(BiddingListing) onAdd;
  final void Function(BiddingListing) onRemove;
  final void Function(BiddingListing) onUpdate;

  const OfferPointHomeScreen({
    super.key,
    required this.listings,
    required this.onAdd,
    required this.onRemove,
    required this.onUpdate,
  });

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
                                onTap: () {
                                  Navigator.pushNamed(context, '/addbidding');
                                },
                              ),
                            ],
                          ),
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
                                '${listings.length} listings',
                                style: const TextStyle(
                                  color: Color(0xFF5D6878),
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
                    sliver: SliverList.builder(
                      itemCount: listings.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 18),
                          child: BiddingCard(
                            listing: listings[index],
                            animationDelay: index * 90,
                            onEdit: (listing) {
                              Navigator.pushNamed(
                                context,
                                '/addbidding',
                                arguments: listing,
                              );
                            },
                            onDelete: onRemove,
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
        onTap: onTap,
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
                Icon(Icons.add_rounded, color: Colors.white, size: 20),
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