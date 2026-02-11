import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository/checkout_repository_impl.dart';
import '../../domain/entities/delivery_slot_entity.dart';
import '../providers/delivery_slots_notifier.dart';
import '../providers/providers.dart';

void main() {
  group('DeliverySlotsNotifier', () {
    late ProviderContainer container;
    late CheckoutRepositoryImpl mockRepository;

    setUp(() {
      mockRepository = CheckoutRepositoryImpl();
      container = ProviderContainer(
        overrides: [
          checkoutRepositoryProvider.overrideWithValue(mockRepository),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('initial state has default values', () {
      final notifier = container.read(deliverySlotsNotifierProvider);

      expect(notifier.status, DeliverySlotStatus.initial);
      expect(notifier.slots, isEmpty);
      expect(notifier.selectedSlot, isNull);
    });

    test('loadDeliverySlots loads slots successfully', () async {
      final notifier = container.read(deliverySlotsNotifierProvider.notifier);

      await notifier.loadDeliverySlots();

      final state = container.read(deliverySlotsNotifierProvider);
      expect(state.status, DeliverySlotStatus.loaded);
      expect(state.slots, isNotEmpty);
    });

    test('selectSlot updates selected slot', () async {
      final notifier = container.read(deliverySlotsNotifierProvider.notifier);

      await notifier.loadDeliverySlots();

      final state = container.read(deliverySlotsNotifierProvider);
      if (state.slots.isNotEmpty) {
        final firstSlot = state.slots.first;
        notifier.selectSlot(firstSlot);

        final updatedState = container.read(deliverySlotsNotifierProvider);
        expect(updatedState.selectedSlot?.id, firstSlot.id);
        expect(updatedState.status, DeliverySlotStatus.selected);
      }
    });

    test('selectSlot ignores unavailable slots', () async {
      final notifier = container.read(deliverySlotsNotifierProvider.notifier);

      await notifier.loadDeliverySlots();

      final unavailableSlot = const DeliverySlotEntity(
        id: 'test_slot',
        date: DateTime.now().subtract(const Duration(days: 1)),
        startTime: TimeOfDay(hour: 10, minute: 0),
        endTime: TimeOfDay(hour: 12, minute: 0),
        isAvailable: false,
        additionalFee: null,
        remainingSlots: 0,
      );

      notifier.selectSlot(unavailableSlot);

      final state = container.read(deliverySlotsNotifierProvider);
      expect(state.selectedSlot, isNull);
    });

    test('clearSelection clears selected slot', () async {
      final notifier = container.read(deliverySlotsNotifierProvider.notifier);

      await notifier.loadDeliverySlots();

      final state = container.read(deliverySlotsNotifierProvider);
      if (state.slots.isNotEmpty) {
        notifier.selectSlot(state.slots.first);
        notifier.clearSelection();

        final clearedState = container.read(deliverySlotsNotifierProvider);
        expect(clearedState.selectedSlot, isNull);
        expect(clearedState.status, DeliverySlotStatus.loaded);
      }
    });

    test('updateInstructions updates delivery instructions', () async {
      final notifier = container.read(deliverySlotsNotifierProvider.notifier);

      notifier.updateInstructions('Ring doorbell twice');

      final state = container.read(deliverySlotsNotifierProvider);
      expect(state.deliveryInstructions, 'Ring doorbell twice');
    });

    test('getSlotById returns correct slot', () async {
      final notifier = container.read(deliverySlotsNotifierProvider.notifier);

      await notifier.loadDeliverySlots();

      final state = container.read(deliverySlotsNotifierProvider);
      if (state.slots.isNotEmpty) {
        final firstSlot = state.slots.first;
        final foundSlot = notifier.getSlotById(firstSlot.id);

        expect(foundSlot?.id, firstSlot.id);
      }
    });

    test('getSlotById returns null for non-existent slot', () async {
      final notifier = container.read(deliverySlotsNotifierProvider.notifier);

      final foundSlot = notifier.getSlotById('non_existent_id');

      expect(foundSlot, isNull);
    });

    test('getSlotsByDate groups slots correctly', () async {
      final notifier = container.read(deliverySlotsNotifierProvider.notifier);

      await notifier.loadDeliverySlots();

      final groupedSlots = notifier.getSlotsByDate();

      expect(groupedSlots, isNotEmpty);
      groupedSlots.forEach((dateKey, slots) {
        expect(slots, isNotEmpty);
      });
    });
  });
}
