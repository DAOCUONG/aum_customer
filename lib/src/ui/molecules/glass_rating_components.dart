import 'package:flutter/material.dart';
import '../theme/glass_design_system.dart';

/// Glass Star Rating component
class GlassStarRating extends StatefulWidget {
  final int starCount;
  final double size;
  final bool allowHalfRating;
  final Function(int)? onRatingChanged;

  const GlassStarRating({
    super.key,
    this.starCount = 5,
    this.size = 32,
    this.allowHalfRating = false,
    this.onRatingChanged,
  });

  @override
  State<GlassStarRating> createState() => _GlassStarRatingState();
}

class _GlassStarRatingState extends State<GlassStarRating> {
  int _currentRating = 4;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.starCount, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _currentRating = index + 1;
            });
            widget.onRatingChanged?.call(_currentRating);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Icon(
              index < _currentRating ? Icons.star : Icons.star_border,
              size: widget.size,
              color: index < _currentRating ? Colors.amber.shade600 : Colors.grey.shade300,
            ),
          ),
        );
      }),
    );
  }
}

/// Glass Rating Card for showing existing rating
class GlassRatingCard extends StatelessWidget {
  final String label;
  final int stars;
  final int maxStars;
  final double size;

  const GlassRatingCard({
    super.key,
    required this.label,
    this.stars = 4,
    this.maxStars = 5,
    this.size = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.3),
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: textSecondary,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(maxStars, (index) {
              return Icon(
                index < stars ? Icons.star : Icons.star_border,
                size: size,
                color: index < stars
                    ? const Color(0xFFFFD60A)
                    : Colors.grey.shade300,
              );
            }),
          ),
        ],
      ),
    );
  }
}

/// Glass Feedback Checkbox Item
class GlassFeedbackCheckbox extends StatefulWidget {
  final String label;
  final Color checkedColor;
  final Color uncheckedColor;
  final bool isChecked;
  final ValueChanged<bool> onChanged;

  const GlassFeedbackCheckbox({
    super.key,
    required this.label,
    this.checkedColor = successGreen,
    this.uncheckedColor = Colors.grey,
    this.isChecked = false,
    required this.onChanged,
  });

  @override
  State<GlassFeedbackCheckbox> createState() => _GlassFeedbackCheckboxState();
}

class _GlassFeedbackCheckboxState extends State<GlassFeedbackCheckbox> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isChecked = !_isChecked;
        });
        widget.onChanged(_isChecked);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.4),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: _isChecked ? widget.checkedColor : Colors.transparent,
                border: Border.all(
                  color: _isChecked ? widget.checkedColor : Colors.grey.shade300,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: _isChecked
                  ? const Icon(
                      Icons.check,
                      size: 12,
                      color: Colors.white,
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Text(
              widget.label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Glass Feedback Section Card
class GlassFeedbackSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final List<GlassFeedbackCheckbox> checkboxes;

  const GlassFeedbackSection({
    super.key,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.checkboxes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: iconColor.withValues(alpha: 0.08),
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        border: Border.all(
          color: iconColor.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 18,
                color: iconColor,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: iconColor,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: checkboxes,
          ),
        ],
      ),
    );
  }
}

/// Glass Success Check Animation
class GlassSuccessCheck extends StatelessWidget {
  final double size;
  final Color color;

  const GlassSuccessCheck({
    super.key,
    this.size = 96,
    this.color = successGreen,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Glow effect
        Container(
          width: size + 40,
          height: size + 40,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                color.withValues(alpha: 0.3),
                color.withValues(alpha: 0.1),
                Colors.transparent,
              ],
              stops: const [0.3, 0.7, 1],
            ),
          ),
        ),
        // Check circle
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: 0.9),
                Colors.white.withValues(alpha: 0.4),
              ],
            ),
            borderRadius: BorderRadius.circular(size / 2),
            border: Border.all(color: Colors.white.withValues(alpha: 0.8)),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.25),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Icon(
            Icons.check,
            size: size * 0.5,
            color: color,
          ),
        ),
      ],
    );
  }
}

/// Glass Order Items List
class GlassOrderItemsList extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final String total;
  final String? orderNumber;
  final VoidCallback? onReceiptTap;

  const GlassOrderItemsList({
    super.key,
    required this.items,
    required this.total,
    this.orderNumber,
    this.onReceiptTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.5),
        borderRadius: const BorderRadius.all(Radius.circular(32)),
        border: Border.all(color: Colors.white.withValues(alpha: 0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with restaurant info and receipt button
          Row(
            children: [
              // Restaurant logo placeholder
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.6)),
                ),
                child: const Icon(
                  Icons.restaurant,
                  color: primaryColor,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Restaurant Name',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: textPrimary,
                      ),
                    ),
                    Text(
                      'Address',
                      style: TextStyle(
                        fontSize: 12,
                        color: textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              if (onReceiptTap != null)
                TextButton(
                  onPressed: onReceiptTap,
                  child: Text(
                    'Receipt',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Divider(color: Colors.black.withValues(alpha: 0.05)),
          const SizedBox(height: 12),
          // Items
          ...List.generate(items.length, (index) {
            final item = items[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
                    ),
                    child: Text(
                      '${item['quantity']}x',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      item['name'],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: textPrimary,
                      ),
                    ),
                  ),
                  Text(
                    item['price'],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: textSecondary,
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 16),
          Divider(color: Colors.black.withValues(alpha: 0.05)),
          const SizedBox(height: 8),
          // Total
          Row(
            children: [
              Text(
                'Total Paid',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: textSecondary,
                ),
              ),
              const Spacer(),
              Text(
                total,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: textPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
