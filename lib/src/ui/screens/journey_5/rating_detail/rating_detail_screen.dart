import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../atoms/glass_button.dart';
import '../../../theme/glass_design_system.dart';

class RatingDetailScreen extends StatefulWidget {
  const RatingDetailScreen({super.key});

  @override
  State<RatingDetailScreen> createState() => _RatingDetailScreenState();
}

class _RatingDetailScreenState extends State<RatingDetailScreen> {
  int _rating = 4;
  final List<String> _positiveFeedback = [];
  final List<String> _negativeFeedback = [];
  final TextEditingController _feedbackController = TextEditingController();

  final List<String> positiveOptions = ['Taste', 'Portion', 'Temperature', 'Packaging'];
  final List<String> negativeOptions = ['Late', 'Missing Item', 'Spilled', 'Wrong Item'];

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: meshGradient,
        ),
        child: Column(
          children: [
            // Header
            _buildHeader(),
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    // Restaurant info
                    _buildRestaurantInfo(),
                    const SizedBox(height: 32),
                    // Star rating
                    _buildStarRating(),
                    const SizedBox(height: 32),
                    // Feedback sections
                    _buildFeedbackSections(),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.4),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            GlassButton.icon(
              onPressed: () => context.pop(),
              icon: Icons.close,
              size: 40,
            ),
            const Expanded(
              child: Text(
                'Rate Order',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildRestaurantInfo() {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: Colors.white, width: 3),
            boxShadow: [glassShadow],
          ),
          child: const Image(
            image: NetworkImage(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuDrTAbWkngsaWBd_eCoPqKD3VNe9NgtawbK7ttK39xPAlk5EDLkNcoEU_FzatGZaUokwVy1xh9EoeoeiVmGeGogKF_ns6UhnHsJSBoVyEg3LMbpXOSAXRgl7d1d_QmyjMf0lKw5DJN64xiIxrJNX-8B0bcLj78i8IYQHZEmad9NK9_TG118pFB5g4k1WBesBxGuWMEYfg-fw9v345KOsh_TpXa7YNywnsyOG-FUsIOuIiOQkJ2Sslx_1_ifUSFwXyUWMDGgreWk2Vk',
            ),
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'How was your order?',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: 'Order from ',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: textSecondary,
                ),
              ),
              const TextSpan(
                text: 'Foodie Express',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStarRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _rating = index + 1;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            child: Icon(
              index < _rating ? Icons.star : Icons.star_border,
              size: 48,
              color: index < _rating
                  ? const Color(0xFFFFD60A)
                  : Colors.grey.shade300,
            ),
          ),
        );
      }),
    );
  }

  Widget _buildFeedbackSections() {
    return Column(
      children: [
        // What went well
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: successGreen.withValues(alpha: 0.08),
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            border: Border.all(
              color: successGreen.withValues(alpha: 0.2),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.thumb_up,
                    size: 18,
                    color: successGreen,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'What went well?',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: successGreen,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: positiveOptions.map((option) {
                  final isSelected = _positiveFeedback.contains(option);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _positiveFeedback.remove(option);
                        } else {
                          _positiveFeedback.add(option);
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? successGreen : Colors.white.withValues(alpha: 0.4),
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                        border: Border.all(
                          color: isSelected ? successGreen : Colors.white.withValues(alpha: 0.5),
                        ),
                      ),
                      child: Text(
                        option,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isSelected ? Colors.white : textPrimary,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Any issues
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: errorRed.withValues(alpha: 0.08),
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            border: Border.all(
              color: errorRed.withValues(alpha: 0.2),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.thumb_down,
                    size: 18,
                    color: errorRed,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Any issues?',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: errorRed,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: negativeOptions.map((option) {
                  final isSelected = _negativeFeedback.contains(option);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _negativeFeedback.remove(option);
                        } else {
                          _negativeFeedback.add(option);
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? errorRed : Colors.white.withValues(alpha: 0.4),
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                        border: Border.all(
                          color: isSelected ? errorRed : Colors.white.withValues(alpha: 0.5),
                        ),
                      ),
                      child: Text(
                        option,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isSelected ? Colors.white : textPrimary,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Additional feedback
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.5),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
          ),
          child: TextField(
            controller: _feedbackController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Tell us more about your experience (optional)',
              hintStyle: TextStyle(color: textSecondary),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
            ),
            style: const TextStyle(
              fontSize: 14,
              color: textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
