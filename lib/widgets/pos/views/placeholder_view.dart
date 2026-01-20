import 'package:flutter/material.dart';

/// Placeholder view for features that are not yet implemented
class PlaceholderView extends StatelessWidget {
  final String title;
  final IconData icon;
  final String description;

  const PlaceholderView({
    super.key,
    required this.title,
    required this.icon,
    this.description = 'This feature is coming soon!',
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF5F5F5),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 64,
              color: isDark 
                  ? const Color(0xFF737373) 
                  : const Color(0xFFA3A3A3),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              fontSize: 16,
              color: isDark 
                  ? const Color(0xFFA3A3A3) 
                  : const Color(0xFF737373),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
