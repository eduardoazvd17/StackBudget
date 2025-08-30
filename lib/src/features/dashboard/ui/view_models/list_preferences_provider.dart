import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stackbudget/src/core/services/services.dart';

// Providers para o estado de expansão das listas
final recurringTransactionsExpandedProvider = StateProvider<bool>(
  (ref) => true,
);
final installmentTransactionsExpandedProvider = StateProvider<bool>(
  (ref) => true,
);
final oneTimeTransactionsExpandedProvider = StateProvider<bool>((ref) => true);

// Provider para o serviço de preferências
final listPreferencesServiceProvider = FutureProvider<ListPreferencesService>((
  ref,
) async {
  return await ListPreferencesService.getInstance();
});

// Provider para carregar as preferências salvas
final loadListPreferencesProvider = FutureProvider<void>((ref) async {
  final service = await ref.watch(listPreferencesServiceProvider.future);

  // Carregar estados salvos
  final recurringExpanded = await service.getRecurringTransactionsExpanded();
  final installmentExpanded =
      await service.getInstallmentTransactionsExpanded();
  final oneTimeExpanded = await service.getOneTimeTransactionsExpanded();

  // Atualizar os providers
  ref.read(recurringTransactionsExpandedProvider.notifier).state =
      recurringExpanded;
  ref.read(installmentTransactionsExpandedProvider.notifier).state =
      installmentExpanded;
  ref.read(oneTimeTransactionsExpandedProvider.notifier).state =
      oneTimeExpanded;
});

// Métodos para salvar as preferências
class ListPreferencesNotifier {
  static Future<void> setRecurringExpanded(WidgetRef ref, bool expanded) async {
    ref.read(recurringTransactionsExpandedProvider.notifier).state = expanded;
    final service = await ref.read(listPreferencesServiceProvider.future);
    await service.setRecurringTransactionsExpanded(expanded);
  }

  static Future<void> setInstallmentExpanded(
    WidgetRef ref,
    bool expanded,
  ) async {
    ref.read(installmentTransactionsExpandedProvider.notifier).state = expanded;
    final service = await ref.read(listPreferencesServiceProvider.future);
    await service.setInstallmentTransactionsExpanded(expanded);
  }

  static Future<void> setOneTimeExpanded(WidgetRef ref, bool expanded) async {
    ref.read(oneTimeTransactionsExpandedProvider.notifier).state = expanded;
    final service = await ref.read(listPreferencesServiceProvider.future);
    await service.setOneTimeTransactionsExpanded(expanded);
  }
}
