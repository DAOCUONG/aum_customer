import 'package:flutter/material.dart';
import '../theme/glass_theme.dart';
import '../atoms/glass_badge.dart';

/// GlassRatingBadge - Rating display component with stars
///
/// Shows rating with star icons and optional review count
class GlassRatingBadge extends StatelessWidget {
  final double rating;
  final int? reviewCount;
  final int starCount;
  final GlassRatingSize size;
  final bool showRatingValue;
  final bool showReviewCount;
  final Color? starColor;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  const GlassRatingBadge({
    super.key,
    required this.rating,
    this.reviewCount,
    this.starCount = 5,
    this.size = GlassRatingSize.medium,
    this.showRatingValue = true,
    this.showReviewCount = true,
    this.starColor,
    this.backgroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);
    final effectiveStarColor = starColor ?? GlassTheme.success;
    final effectiveBackgroundColor =
        backgroundColor ?? const Color(0xFF34C759).withOpacity(0.15);

    final stars = Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(starCount, (index) {
        if (index < rating.floor()) {
          return Icon(
            Icons.star,
            size: _getStarSize(),
            color: effectiveStarColor,
          );
        } else if (index < rating) {
          return Icon(
            Icons.star_half,
            size: _getStarSize(),
            color: effectiveStarColor,
          );
        } else {
          return Icon(
            Icons.star_border,
            size: _getStarSize(),
            color: effectiveStarColor.withOpacity(0.4),
          );
        }
      }),
    );

    final child = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        stars,
        if (showRatingValue) ...[
          const SizedBox(width: 4),
          Text(
            rating.toStringAsFixed(rating.truncateToDouble() == rating ? 0 : 1),
            style: TextStyle(
              fontSize: _getFontSize(),
              fontWeight: FontWeight.w600,
              color: const Color(0xFF34C759),
            ),
          ),
        ],
        if (showReviewCount && reviewCount != null) ...[
          const SizedBox(width: 4),
          Text(
            '($reviewCount)',
            style: TextStyle(
              fontSize: _getFontSize() * 0.9,
              fontWeight: FontWeight.w500,
              color: theme.textTertiary,
            ),
          ),
        ],
      ],
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: child);
    }

    return child;
  }

  double _getStarSize() {
    switch (size) {
      case GlassRatingSize.small:
        return 12.0;
      case GlassRatingSize.medium:
        return 14.0;
      case GlassRatingSize.large:
        return 16.0;
      case GlassRatingSize.extraLarge:
        return 20.0;
    }
  }

  double _getFontSize() {
    switch (size) {
      case GlassRatingSize.small:
        return 10.0;
      case GlassRatingSize.medium:
        return 11.0;
      case GlassRatingSize.large:
        return 13.0;
      case GlassRatingSize.extraLarge:
        return 15.0;
    }
  }
}

enum GlassRatingSize {
  small,
  medium,
  large,
  extraLarge,
}

/// Rating chip with glass effect
class GlassRatingChip extends StatelessWidget {
  final double rating;
  final GlassRatingSize size;
  final VoidCallback? onTap;

  const GlassRatingChip({
    super.key,
    required this.rating,
    this.size = GlassRatingSize.medium,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);
    final starSize = size == GlassRatingSize.small ? 10.0 : 12.0;
    final fontSize = size == GlassRatingSize.small ? 10.0 : 11.0;

    final child = Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF34C759).withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFF34C759).withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star,
            size: starSize,
            color: const Color(0xFF34C759),
          ),
          const SizedBox(width: 3),
          Text(
            rating.toStringAsFixed(1),
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF34C759),
            ),
          ),
        ],
      ),
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: child);
    }

    return child;
  }
}

/// Interactive rating selector
class GlassRatingSelector extends StatefulWidget {
  final int starCount;
  final double initialRating;
  final Function(double rating) onRatingChanged;
  final double size;
  final Color? activeColor;
  final Color? inactiveColor;

  const GlassRatingSelector({
    super.key,
    this.starCount = 5,
    this.initialRating = 0,
    required this.onRatingChanged,
    this.size = 32,
    this.activeColor,
    this.inactiveColor,
  });

  @override
  State<GlassRatingSelector> createState() => _GlassRatingSelectorState();
}

class _GlassRatingSelectorState extends State<GlassRatingSelector> {
  late double _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);
    final activeColor = widget.activeColor ?? GlassTheme.primary;
    final inactiveColor =
        widget.inactiveColor ?? theme.textTertiary.withOpacity(0.4);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.starCount, (index) {
        final starRating = index + 1;
        final isActive = starRating <= _currentRating;

        return GestureDetector(
          onTap: () {
            setState(() => _currentRating = starRating.toDouble());
            widget.onRatingChanged(starRating.toDouble());
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Icon(
              isActive ? Icons.star : Icons.star_border,
              size: widget.size,
              color: isActive ? activeColor : inactiveColor,
            ),
          ),
        );
      }),
    );
  }
}

/// Review summary component
class GlassReviewSummary extends StatelessWidget {
  final double averageRating;
  final int totalReviews;
  final Map<int, int> ratingCounts;
  final VoidCallback? onSeeAll;

  const GlassReviewSummary({
    super.key,
    required this.averageRating,
    required this.totalReviews,
    required this.ratingCounts,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF34C759).withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFF34C759).withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Text(
                averageRating.toStringAsFixed(1),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF34C759),
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < averageRating.floor()
                        ? Icons.star
                        : (index < averageRating ? Icons.star_half : Icons.star_border),
                    size: 14,
                    color: const Color(0xFF34C759),
                  );
                }),
              ),
              const SizedBox(height: 4),
              Text(
                '$totalReviews reviews',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: theme.textTertiary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            children: [5, 4, 3, 2, 1].map((star) {
              final count = ratingCounts[star] ?? 0;
              final percentage =
                  totalReviews > 0 ? count / totalReviews : 0.0;

              return Row(
                children: [
                  Text(
                    '$star',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: theme.textSecondary,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: LinearProgressIndicator(
                      value: percentage,
                      minHeight: 6,
                      backgroundColor: theme.glassSurface.withOpacity(0.5),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFF34C759),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  SizedBox(
                    width: 30,
                    child: Text(
                      '$count',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: theme.textTertiary,
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
