/// Configuração de rotas do aplicativo
///
/// Define todas as rotas disponíveis seguindo a estrutura de features
class AppRoutesConfig {
  AppRoutesConfig._();

  // Auth Routes
  static const String auth = 'auth';

  // Home Routes
  static const String home = 'home';

  // Transaction Routes (futuras)
  static const String transactions = 'transactions';
  static const String addTransaction = 'add-transaction';
  static const String transactionDetail = 'transaction-detail';
  static const String editTransaction = 'edit-transaction';

  // Budget Routes (futuras)
  static const String budget = 'budget';
  static const String monthlyBudget = 'monthly-budget';

  // Profile Routes (futuras)
  static const String profile = 'profile';
  static const String settings = 'settings';

  // Reports Routes (futuras)
  static const String reports = 'reports';
  static const String monthlyReport = 'monthly-report';
  static const String yearlyReport = 'yearly-report';

  // Paths completos
  static const String authPath = '/$auth';
  static const String homePath = '/';
  static const String transactionsPath = '/$transactions';
  static const String addTransactionPath = '/$addTransaction';
  static const String transactionDetailPath = '/$transactionDetail';
  static const String editTransactionPath = '/$editTransaction';
  static const String budgetPath = '/$budget';
  static const String monthlyBudgetPath = '/$monthlyBudget';
  static const String profilePath = '/$profile';
  static const String settingsPath = '/$settings';
  static const String reportsPath = '/$reports';
  static const String monthlyReportPath = '/$monthlyReport';
  static const String yearlyReportPath = '/$yearlyReport';
}

/// Estrutura planejada de navegação:
///
/// - / (home) - Dashboard principal com resumo mensal
///   - /transactions - Lista de transações
///     - /add-transaction - Adicionar nova transação
///     - /edit-transaction/:id - Editar transação
///   - /budget - Visualização do orçamento
///     - /monthly-budget/:year/:month - Orçamento mensal específico
///   - /reports - Relatórios
///     - /monthly-report/:year/:month - Relatório mensal
///     - /yearly-report/:year - Relatório anual
///   - /profile - Perfil do usuário
///   - /settings - Configurações
/// - /auth - Autenticação (login/cadastro)
