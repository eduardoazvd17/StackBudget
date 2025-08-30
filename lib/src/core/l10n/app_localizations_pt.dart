// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get frequencyOneTime => 'Única';

  @override
  String get frequencyMonthly => 'Mensal';

  @override
  String get frequencyYearly => 'Anual';

  @override
  String get frequencyInstallment => 'Parcelado';

  @override
  String get frequency => 'Frequência';

  @override
  String get selectFrequency => 'Selecione a frequência';

  @override
  String get selectFrequencyRequired => 'Selecione uma frequência';

  @override
  String get monthlySettings => 'Configurações Mensais';

  @override
  String get startMonth => 'Mês de Início';

  @override
  String get endMonth => 'Mês de Fim';

  @override
  String get selectStartMonth => 'Selecione o mês de início';

  @override
  String get selectEndMonth => 'Selecione o mês de fim';

  @override
  String get yearlySettings => 'Configurações Anuais';

  @override
  String get yearlyMonth => 'Mês do Ano';

  @override
  String get selectYearlyMonth => 'Em qual mês ocorre anualmente';

  @override
  String get selectMonthRequired => 'Selecione o mês';

  @override
  String get installmentSettings => 'Configurações de Parcelamento';

  @override
  String get totalInstallments => 'Total de Parcelas';

  @override
  String get enterTotalInstallments => 'Digite o número total de parcelas';

  @override
  String get installmentsRequired => 'Número de parcelas é obrigatório';

  @override
  String get installmentsMinValue => 'Deve ter pelo menos 2 parcelas';

  @override
  String get startDateRequired => 'Selecione uma data de início';

  @override
  String get endDateAfterStart => 'A data de fim deve ser posterior à data de início';

  @override
  String endDateAfterStartSpecific(String startMonth, String startYear) {
    return 'Deve ser posterior a $startMonth/$startYear';
  }

  @override
  String get transactions => 'Transações';

  @override
  String get recurringTransactions => 'Transações Recorrentes';

  @override
  String get installments => 'Parcelas';

  @override
  String get monthlyTransactions => 'Transações do Mês';

  @override
  String get noTransactionsFound => 'Nenhuma transação encontrada';

  @override
  String get addFirstTransaction => 'Adicione sua primeira transação para começar';

  @override
  String get newTransaction => 'Nova Transação';

  @override
  String get title => 'Título';

  @override
  String get enterTitle => 'Digite o título da transação';

  @override
  String get titleRequired => 'Título *';

  @override
  String get description => 'Descrição';

  @override
  String get enterDescription => 'Digite a descrição (opcional)';

  @override
  String get amount => 'Valor';

  @override
  String get enterAmount => 'Digite o valor';

  @override
  String get amountRequired => 'Valor *';

  @override
  String get amountPositive => 'O valor deve ser maior que zero';

  @override
  String get type => 'Tipo';

  @override
  String get income => 'Receita';

  @override
  String get expense => 'Despesa';

  @override
  String get category => 'Categoria';

  @override
  String get selectCategory => 'Selecione categoria (opcional)';

  @override
  String get save => 'Salvar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get edit => 'Editar';

  @override
  String get delete => 'Excluir';

  @override
  String get deleteConfirmation => 'Excluir Transação';

  @override
  String get deleteConfirmationMessage => 'Tem certeza que deseja excluir esta transação? Esta ação não pode ser desfeita.';

  @override
  String get yes => 'Sim';

  @override
  String get no => 'Não';

  @override
  String get error => 'Erro';

  @override
  String get loading => 'Carregando...';

  @override
  String get success => 'Sucesso';

  @override
  String get transactionSaved => 'Transação salva com sucesso';

  @override
  String get transactionDeleted => 'Transação excluída com sucesso';

  @override
  String get errorSavingTransaction => 'Erro ao salvar transação';

  @override
  String get errorDeletingTransaction => 'Erro ao excluir transação';

  @override
  String get errorLoadingTransactions => 'Erro ao carregar transações';

  @override
  String get unexpectedError => 'Erro inesperado';

  @override
  String get userNotAuthenticated => 'Usuário não autenticado';

  @override
  String get currentInstallment => 'Parcela Atual';

  @override
  String get ofPreposition => 'de';

  @override
  String get monthlyInformation => 'Informações Mensais';

  @override
  String get installmentInformation => 'Informações de Parcelamento';

  @override
  String get yearlyInformation => 'Informações Anuais';

  @override
  String get startMonthLabel => 'Mês de Início';

  @override
  String get endMonthLabel => 'Mês de Fim';

  @override
  String get totalAmount => 'Valor Total';

  @override
  String get installmentAmount => 'Valor da Parcela';

  @override
  String get yearlyMonthLabel => 'Mês do Ano';

  @override
  String get adjustMonthlyValue => 'Ajustar valor deste mês';

  @override
  String get currentValue => 'Valor Atual';

  @override
  String get defaultValue => 'Valor Padrão';

  @override
  String get notes => 'Observações';

  @override
  String get enterNotes => 'Digite observações (opcional)';

  @override
  String get customAmount => 'Valor Personalizado';

  @override
  String get hasAdjustment => 'Tem ajuste';

  @override
  String get transactionType => 'Tipo da Transação';

  @override
  String get moneyIn => 'Dinheiro que entra';

  @override
  String get moneyOut => 'Dinheiro que sai';

  @override
  String get saving => 'Salvando...';

  @override
  String get updateTransaction => 'Atualizar Transação';

  @override
  String get saveTransaction => 'Salvar Transação';

  @override
  String get additionalDetails => 'Detalhes adicionais (opcional)';

  @override
  String get selectStartDate => 'Selecione quando começar';

  @override
  String get selectEndDate => 'Selecione a data de fim';

  @override
  String get selectStartDateFirst => 'Selecione primeiro a data de início';

  @override
  String get enterInstallments => 'Digite o número de parcelas';

  @override
  String get installmentsPositive => 'Deve ser um número maior que zero';

  @override
  String get selectFirstInstallmentMonth => 'Selecione o mês da primeira parcela';

  @override
  String get installmentValue => 'Valor da parcela';

  @override
  String get firstInstallmentMonth => 'Mês da 1ª Parcela';

  @override
  String get titleHint => 'Ex: Salário, Aluguel, Supermercado...';

  @override
  String get amountHint => 'R\$ 0,00';

  @override
  String get endMonthOptional => 'Mês de Fim (opcional)';

  @override
  String get startMonthRequired => 'Mês de Início *';

  @override
  String get yearlyMonthRequired => 'Mês do Ano *';

  @override
  String get totalInstallmentsRequired => 'Total de Parcelas *';

  @override
  String get categoryRequired => 'Categoria *';

  @override
  String get dashboardTransactions => 'Transações';

  @override
  String get adjusted => 'Ajustado';

  @override
  String get transactionDetails => 'Detalhes da Transação';

  @override
  String get generalInformation => 'Informações Gerais';

  @override
  String get dates => 'Datas';

  @override
  String get createdAt => 'Criado em';

  @override
  String get updatedAt => 'Atualizado em';

  @override
  String get tags => 'Tags';

  @override
  String get confirmDelete => 'Confirmar Exclusão';

  @override
  String get deletedTransaction => 'Transação excluída';
}
