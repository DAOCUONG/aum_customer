import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../atoms/glass_button.dart';
import '../../../molecules/glass_delivery_components.dart';
import '../../../theme/glass_design_system.dart';

class ScheduleDeliveryScreen extends StatefulWidget {
  const ScheduleDeliveryScreen({super.key});

  @override
  State<ScheduleDeliveryScreen> createState() => _ScheduleDeliveryScreenState();
}

class _ScheduleDeliveryScreenState extends State<ScheduleDeliveryScreen> {
  int selectedDateIndex = 0;
  int selectedTimeIndex = 0;

  final List<Map<String, dynamic>> dates = [
    {'label': 'Today', 'day': 24},
    {'label': 'Fri', 'day': 25},
    {'label': 'Sat', 'day': 26},
    {'label': 'Sun', 'day': 27},
    {'label': 'Mon', 'day': 28},
  ];

  final List<Map<String, dynamic>> timeSlots = [
    {
      'time': '12:00 PM - 12:30 PM',
      'label': 'Lunch Peak',
      'icon': Icons.wb_sunny,
      'isPeak': true,
      'isUnavailable': false,
    },
    {
      'time': '12:30 PM - 1:00 PM',
      'label': 'Standard Delivery',
      'icon': Icons.schedule,
      'isPeak': false,
      'isUnavailable': false,
    },
    {
      'time': '1:00 PM - 1:30 PM',
      'label': 'Standard Delivery',
      'icon': Icons.schedule,
      'isPeak': false,
      'isUnavailable': false,
    },
    {
      'time': '1:30 PM - 2:00 PM',
      'label': 'Standard Delivery',
      'icon': Icons.schedule,
      'isPeak': false,
      'isUnavailable': false,
    },
    {
      'time': '2:00 PM - 2:30 PM',
      'label': 'Standard Delivery',
      'icon': Icons.schedule,
      'isPeak': false,
      'isUnavailable': false,
    },
    {
      'time': '11:30 AM - 12:00 PM',
      'label': 'Unavailable',
      'icon': Icons.block,
      'isPeak': false,
      'isUnavailable': true,
    },
  ];

  String get selectedDate {
    return '${selectedDateIndex == 0 ? 'Today' : dates[selectedDateIndex]['label']}';
  }

  String get selectedTime {
    return timeSlots[selectedTimeIndex]['time'].split(' - ')[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: meshGradient,
        ),
        child: Stack(
          children: [
            Column(
              children: [
                // Header
                _buildHeader(),
                // Date Selection
                _buildDateSelection(),
                // Time Slots
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),
                        _buildInfoCard(),
                        const SizedBox(height: 24),
                        const Text(
                          'Available Times',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: textTertiary,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ...List.generate(timeSlots.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: GlassTimeSlotCard(
                              timeRange: timeSlots[index]['time'],
                              label: timeSlots[index]['label'],
                              isSelected: selectedTimeIndex == index && !timeSlots[index]['isUnavailable'],
                              isUnavailable: timeSlots[index]['isUnavailable'],
                              icon: timeSlots[index]['icon'],
                              onTap: () {
                                if (!timeSlots[index]['isUnavailable']) {
                                  setState(() => selectedTimeIndex = index);
                                }
                              },
                            ),
                          );
                        }),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Bottom Button
            _buildBottomButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.7),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        border: Border(bottom: BorderSide(color: Colors.white.withValues(alpha: 0.3))),
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            GlassButton.icon(
              onPressed: () => context.pop(),
              icon: Icons.arrow_back_ios_new,
              size: 40,
            ),
            const Expanded(
              child: Text(
                'Schedule Order',
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

  Widget _buildDateSelection() {
    return Container(
      padding: const EdgeInsets.only(left: 20, bottom: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(dates.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: GlassDateChip(
                dayLabel: dates[index]['label'],
                dateNumber: dates[index]['day'],
                isActive: selectedDateIndex == index,
                onTap: () => setState(() => selectedDateIndex = index),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50.withValues(alpha: 0.45),
        borderRadius: const BorderRadius.all(cardRadius),
        border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.shade100.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.schedule,
              size: 20,
              color: Colors.blue.shade600,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Estimated Arrival',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Choose a time slot below. Your driver will arrive within a 15-minute window of your selection.',
                  style: TextStyle(
                    fontSize: 13,
                    color: textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.7),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
          border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.4))),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    'Selected Time',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: textSecondary,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '$selectedDate, $selectedTime',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              GlassButton.primary(
                onPressed: () => context.push('/order-success'),
                child: const Center(
                  child: Text(
                    'Confirm Time',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
