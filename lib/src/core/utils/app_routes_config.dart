/// Configuração de rotas do aplicativo
///
/// Define todas as rotas disponíveis seguindo a estrutura simples e neutra
class AppRoutesConfig {
  AppRoutesConfig._();

  // Auth Routes
  static const String auth = 'auth';

  // Transaction Routes
  static const String transactions = 'transactions';
  static const String transactionDetail = 'transaction-detail';
  static const String addTransaction = 'add';
  static const String editTransaction = 'edit';

  // Future Routes
  static const String budget = 'budget';
  static const String profile = 'profile';
  static const String settings = 'settings';
  static const String reports = 'reports';

  // Paths completos
  static const String authPath = '/$auth';
  static const String transactionsPath = '/$transactions';
  static const String addTransactionPath = '/$transactions/$addTransaction';
  static const String budgetPath = '/$budget';
  static const String profilePath = '/$profile';
  static const String settingsPath = '/$settings';
  static const String reportsPath = '/$reports';
}

/// Estrutura de navegação:
///
/// - /auth - Autenticação (login/cadastro)
/// - /transactions - Dashboard principal com lista de transações
///   - /transactions/:id - Detalhes de uma transação específica
///   - /transactions/add - Adicionar nova transação
///   - /transactions/:id/edit - Editar transação específica
/// - /budget - Visualização do orçamento (futuro)
/// - /profile - Perfil do usuário (futuro)
/// - /settings - Configurações (futuro)
/// - /reports - Relatórios (futuro)
