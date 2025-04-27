import 'package:flutter/material.dart';
import 'constants.dart';

class BottomNavBar extends StatefulWidget {
  final Function(int) onTabSelected; // Callback function to update state
  final int currentIndex; // Current index of the bottom navigation bar
  
  const BottomNavBar({
    super.key,
    required this.onTabSelected,
    required this.currentIndex,
    });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  
  final List<IconData> bottomNavItemsActive = [
    Icons.home,
    Icons.diversity_1,
    Icons.how_to_vote,
    Icons.area_chart,
    Icons.account_circle,
  ];
  final List<IconData> bottomNavItemsInactive = [
    Icons.home_outlined,
    Icons.diversity_1_outlined,
    Icons.how_to_vote_outlined,
    Icons.area_chart_outlined,
    Icons.account_circle_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: Constants.primaryColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
                BoxShadow(
                  color: Constants.primaryColor.withValues(alpha: .3), 
                  offset: const Offset(0, 20),
                  blurRadius: 20
                  )
              ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(bottomNavItemsActive.length, 
            (index) {
              return TextButton(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    widget.currentIndex == index ? bottomNavItemsActive[index] : bottomNavItemsInactive[index],
                    color: widget.currentIndex == index ? Constants.secondaryColor : Constants.secondaryColor.withAlpha(50),
                    size: 24,
                  ),
                ),
                onPressed: () => setState(() {
                widget.onTabSelected(index); // Call the callback function
                })
             );
            }
          ),
        ),
      );
  }
}