import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stackbudget/src/core/services/services.dart';

// Provider para gerenciar o estado de expansão
class ExpansionState {
  final bool recurringExpanded;
  final bool installmentExpanded;
  final bool oneTimeExpanded;

  ExpansionState({
    required this.recurringExpanded,
    required this.installmentExpanded,
    required this.oneTimeExpanded,
  });

  ExpansionState copyWith({
    bool? recurringExpanded,
    bool? installmentExpanded,
    bool? oneTimeExpanded,
  }) {
    return ExpansionState(
      recurringExpanded: recurringExpanded ?? this.recurringExpanded,
      installmentExpanded: installmentExpanded ?? this.installmentExpanded,
      oneTimeExpanded: oneTimeExpanded ?? this.oneTimeExpanded,
    );
  }
}

// StateNotifier para gerenciar o estado
class ExpansionStateNotifier extends StateNotifier<ExpansionState?> {
  ExpansionStateNotifier() : super(null) {
    _loadInitialState();
  }

  Future<void> _loadInitialState() async {
    try {
      final service = await ListPreferencesService.getInstance();

      final recurring = await service.getRecurringTransactionsExpanded();
      final installment = await service.getInstallmentTransactionsExpanded();
      final oneTime = await service.getOneTimeTransactionsExpanded();

      state = ExpansionState(
        recurringExpanded: recurring,
        installmentExpanded: installment,
        oneTimeExpanded: oneTime,
      );
    } catch (e) {
      // Estado padrão em caso de erro
      state = ExpansionState(
        recurringExpanded: true,
        installmentExpanded: true,
        oneTimeExpanded: true,
      );
    }
  }

  Future<void> setRecurringExpanded(bool expanded) async {
    if (state == null) return;

    final service = await ListPreferencesService.getInstance();
    await service.setRecurringTransactionsExpanded(expanded);

    state = state!.copyWith(recurringExpanded: expanded);
  }

  Future<void> setInstallmentExpanded(bool expanded) async {
    if (state == null) return;

    final service = await ListPreferencesService.getInstance();
    await service.setInstallmentTransactionsExpanded(expanded);

    state = state!.copyWith(installmentExpanded: expanded);
  }

  Future<void> setOneTimeExpanded(bool expanded) async {
    if (state == null) return;

    final service = await ListPreferencesService.getInstance();
    await service.setOneTimeTransactionsExpanded(expanded);

    state = state!.copyWith(oneTimeExpanded: expanded);
  }
}

// Provider global
final expansionStateProvider =
    StateNotifierProvider<ExpansionStateNotifier, ExpansionState?>((ref) {
      return ExpansionStateNotifier();
    });
