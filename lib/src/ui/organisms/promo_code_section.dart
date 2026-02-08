import 'package:flutter/material.dart';
import '../theme/glass_theme.dart';
import '../atoms/glass_card.dart';
import '../atoms/glass_input.dart';
import '../atoms/glass_badge.dart';
import '../molecules/glass_price_tag.dart';
import '../molecules/glass_icon_button.dart';

/// PromoCodeSection - Voucher code input with validation
///
/// Displays promo code input with applied state and discount info
class PromoCodeSection extends StatefulWidget {
  final String? appliedCode;
  final double originalTotal;
  final double discountAmount;
  final double deliveryFee;
  final String currencySymbol;
  final Function(String code) onCodeSubmitted;
  final VoidCallback? onRemoveCode;

  const PromoCodeSection({
    super.key,
    this.appliedCode,
    required this.originalTotal,
    required this.discountAmount,
    required this.deliveryFee,
    this.currencySymbol = '\$',
    required this.onCodeSubmitted,
    this.onRemoveCode,
  });

  @override
  State<PromoCodeSection> createState() => _PromoCodeSectionState();
}

class _PromoCodeSectionState extends State<PromoCodeSection> {
  late TextEditingController _codeController;
  bool _isApplied = false;

  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController();
    if (widget.appliedCode != null) {
      _codeController.text = widget.appliedCode!;
      _isApplied = true;
    }
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(PromoCodeSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.appliedCode != widget.appliedCode) {
      if (widget.appliedCode != null) {
        _codeController.text = widget.appliedCode!;
        _isApplied = true;
      } else {
        _codeController.clear();
        _isApplied = false;
      }
    }
  }

  void _applyCode() {
    if (_codeController.text.isNotEmpty) {
      widget.onCodeSubmitted(_codeController.text);
    }
  }

  void _removeCode() {
    _codeController.clear();
    setState(() => _isApplied = false);
    widget.onRemoveCode?.call();
  }

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);
    final finalTotal = widget.originalTotal - widget.discountAmount + widget.deliveryFee;

    return GlassCard(
      variant: GlassCardVariant.atom,
      size: GlassCardSize.small,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Voucher Code',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: theme.textSecondary,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),
          _isApplied
              ? _buildAppliedState(theme)
              : _buildInputState(theme),
          if (_isApplied) ...[
            const SizedBox(height: 12),
            _buildDiscountSummary(theme),
          ],
          const SizedBox(height: 16),
          if (!_isApplied)
            GlassDivider(
              variant: GlassDividerVariant.dashed,
              color: theme.dividerColor.withOpacity(0.5),
            ),
          if (!_isApplied) ...[
            const SizedBox(height: 16),
            _buildTotalsSection(theme, finalTotal),
          ],
        ],
      ),
    );
  }

  Widget _buildAppliedState(GlassTheme theme) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xFF34C759).withOpacity(0.1),
        border: Border.all(
          color: const Color(0xFF34C759).withOpacity(0.3),
          width: 2,
        ),
      ),
      child: TextField(
        controller: _codeController,
        enabled: false,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: theme.textPrimary,
        ),
        decoration: InputDecoration(
          prefixIcon: Container(
            padding: const EdgeInsets.all(12),
            child: Icon(
              Icons.sell,
              size: 22,
              color: const Color(0xFF34C759),
            ),
          ),
          suffixIcon: Container(
            padding: const EdgeInsets.all(8),
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: const Color(0xFF34C759),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.check,
                size: 14,
                color: Colors.white,
              ),
            ),
          ),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  Widget _buildInputState(GlassTheme theme) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: theme.glassInputBg,
              border: Border.all(
                color: theme.glassInputBorder,
                width: 1,
              ),
            ),
            child: TextField(
              controller: _codeController,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: theme.textPrimary,
              ),
              decoration: InputDecoration(
                prefixIcon: Container(
                  padding: const EdgeInsets.all(12),
                  child: Icon(
                    Icons.sell,
                    size: 20,
                    color: theme.textTertiary,
                  ),
                ),
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _applyCode(),
            ),
          ),
        ),
        const SizedBox(width: 12),
        GlassButton(
          onPressed: _applyCode,
          label: 'Apply',
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
      ],
    );
  }

  Widget _buildDiscountSummary(GlassTheme theme) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xFF34C759).withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.verified,
            size: 16,
            color: Color(0xFF34C759),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          'Code applied! You saved ${widget.currencySymbol}${widget.discountAmount.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF34C759),
          ),
        ),
      ],
    );
  }

  Widget _buildTotalsSection(GlassTheme theme, double finalTotal) {
    return Column(
      children: [
        _buildTotalRow(theme, 'Subtotal', widget.originalTotal),
        const SizedBox(height: 8),
        _buildTotalRow(
          theme,
          'Discount (${widget.appliedCode != null ? '25' : '0'}%)',
          -widget.discountAmount,
          isDiscount: true,
        ),
        const SizedBox(height: 8),
        _buildTotalRow(theme, 'Delivery Fee', widget.deliveryFee),
        const SizedBox(height: 12),
        GlassDivider(
          variant: GlassDividerVariant.dashed,
          color: theme.textTertiary.withOpacity(0.3),
        ),
        const SizedBox(height: 12),
        GlassTotalPrice(
          label: 'Total',
          price: finalTotal.toStringAsFixed(2),
          currencySymbol: widget.currencySymbol,
          size: GlassPriceTagSize.large,
        ),
      ],
    );
  }

  Widget _buildTotalRow(
    GlassTheme theme,
    String label,
    double amount, {
    bool isDiscount = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: theme.textSecondary,
          ),
        ),
        Text(
          '${isDiscount ? '-' : ''}${widget.currencySymbol}${amount.abs().toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isDiscount
                ? const Color(0xFF34C759)
                : theme.textPrimary,
          ),
        ),
      ],
    );
  }
}

/// Promo banner card
class PromoBannerCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;

  const PromoBannerCard({
    super.key,
    required this.title,
    this.subtitle,
    this.onTap,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        variant: GlassCardVariant.panel,
        size: GlassCardSize.small,
        padding: padding ?? const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: theme.textPrimary,
                    ),
                  ),
                  if (subtitle != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        subtitle!,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: theme.textSecondary,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            GlassBadge(
              text: 'UP TO 50% OFF',
              variant: GlassBadgeVariant.primary,
              size: GlassBadgeSize.medium,
            ),
          ],
        ),
      ),
    );
  }
}

/// Special offer card
class SpecialOfferCard extends StatelessWidget {
  final String title;
  final String? description;
  final String code;
  final VoidCallback? onCopyCode;
  final VoidCallback? onSeeDetails;

  const SpecialOfferCard({
    super.key,
    required this.title,
    this.description,
    required this.code,
    this.onCopyCode,
    this.onSeeDetails,
  });

  @override
  Widget build(BuildContext context) {
    final theme = GlassTheme.of(context);

    return GlassCard(
      variant: GlassCardVariant.atom,
      size: GlassCardSize.small,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: GlassTheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  code,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: GlassTheme.primary,
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: onCopyCode,
                child: Row(
                  children: [
                    Text(
                      'Copy',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: theme.primaryColor,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.content_copy,
                      size: 14,
                      color: theme.primaryColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: theme.textPrimary,
            ),
          ),
          if (description != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                description!,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: theme.textSecondary,
                ),
              ),
            ),
          if (onSeeDetails != null)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: GestureDetector(
                onTap: onSeeDetails,
                child: Text(
                  'See details',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: theme.primaryColor,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
