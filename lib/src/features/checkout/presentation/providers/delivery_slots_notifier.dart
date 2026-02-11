import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/delivery_slot_entity.dart';
import '../../domain/usecases/checkout_usecases.dart' as usecases;
import 'checkout_state.dart';
import 'providers.dart';

/// Notifier for delivery slot state management
class DeliverySlotsNotifier extends StateNotifier<DeliverySlotState> {
  final usecases.GetDeliverySlotsUseCase _getDeliverySlotsUseCase;

  DeliverySlotsNotifier({required usecases.GetDeliverySlotsUseCase getDeliverySlotsUseCase})
      : _getDeliverySlotsUseCase = getDeliverySlotsUseCase,
        super(const DeliverySlotState());

  /// Load available delivery slots
  Future<void> loadDeliverySlots() async {
    state = state.copyWith(status: DeliverySlotStatus.loading);

    final result = await _getDeliverySlotsUseCase().run();

    result.fold(
      (failure) {
        state = state.copyWith(
          status: DeliverySlotStatus.error,
          errorMessage: failure.message,
        );
      },
      (slots) {
        state = state.copyWith(
          status: DeliverySlotStatus.loaded,
          slots: slots,
        );
      },
    );
  }

  /// Select a delivery slot
  void selectSlot(DeliverySlotEntity slot) {
    if (!slot.isAvailable || slot.isPast) return;

    state = state.copyWith(
      selectedSlot: slot,
      status: DeliverySlotStatus.selected,
    );
  }

  /// Update delivery instructions
  void updateInstructions(String instructions) {
    state = state.copyWith(deliveryInstructions: instructions);
  }

  /// Clear selected slot
  void clearSelection() {
    state = state.copyWith(
      selectedSlot: null,
      status: DeliverySlotStatus.loaded,
    );
  }

  /// Get slot by ID
  DeliverySlotEntity? getSlotById(String slotId) {
    try {
      return state.slots.firstWhere((slot) => slot.id == slotId);
    } catch (e) {
      return null;
    }
  }

  /// Get slots grouped by date
  Map<String, List<DeliverySlotEntity>> getSlotsByDate() {
    final grouped = <String, List<DeliverySlotEntity>>{};
    for (final slot in state.slots) {
      final dateKey = '${slot.date.year}-${slot.date.month}-${slot.date.day}';
      grouped.putIfAbsent(dateKey, () => []).add(slot);
    }
    return grouped;
  }
}

/// Provider for DeliverySlotsNotifier
final deliverySlotsNotifierProvider =
    StateNotifierProvider<DeliverySlotsNotifier, DeliverySlotState>((ref) {
  final repository = ref.watch(checkoutRepositoryProvider);

  return DeliverySlotsNotifier(
    getDeliverySlotsUseCase: usecases.GetDeliverySlotsUseCase(repository),
  );
});

/// Provider for selected delivery slot
final selectedDeliverySlotProvider = Provider<DeliverySlotEntity?>((ref) {
  return ref.watch(deliverySlotsNotifierProvider).selectedSlot;
});
