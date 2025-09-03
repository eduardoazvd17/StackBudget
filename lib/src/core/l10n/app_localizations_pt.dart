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
  String get startMonthField => 'Mês de Início';

  @override
  String get endMonthField => 'Mês de Fim';

  @override
  String get selectStartMonth => 'Selecione o mês de início';

  @override
  String get selectEndMonth => 'Selecione o mês de fim';

  @override
  String get yearlySettings => 'Configurações Anuais';

  @override
  String get yearlyMonthField => 'Mês do Ano';

  @override
  String get selectYearlyMonth => 'Em qual mês ocorre anualmente';

  @override
  String get selectMonthRequired => 'Selecione o mês';

  @override
  String get installmentSettings => 'Configurações de Parcelamento';

  @override
  String get totalInstallmentsField => 'Total de Parcelas';

  @override
  String get enterTotalInstallments => 'Digite o número total de parcelas';

  @override
  String get installmentsRequired => 'Digite o número de parcelas';

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
  String get titleField => 'Título';

  @override
  String get enterTitle => 'Digite o título da transação';

  @override
  String get titleRequired => 'Digite um título';

  @override
  String get description => 'Descrição';

  @override
  String get enterDescription => 'Digite a descrição (opcional)';

  @override
  String get amountField => 'Valor';

  @override
  String get enterAmount => 'Digite o valor';

  @override
  String get amountRequired => 'Digite um valor';

  @override
  String get amountPositive => 'O valor deve ser maior que zero';

  @override
  String get type => 'Tipo';

  @override
  String get income => 'Receita';

  @override
  String get expense => 'Despesa';

  @override
  String get categoryField => 'Categoria';

  @override
  String get selectCategory => 'Selecione categoria (opcional)';

  @override
  String get save => 'Salvar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

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
  String get adjustMonthlyValue => 'Ajustar Valor Mensal';

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
  String get installmentsRequiredForm => 'Número de parcelas é obrigatório';

  @override
  String get installmentsPositive => 'Deve ser um número maior que zero';

  @override
  String get selectFirstInstallmentMonth => 'Selecione o mês da primeira parcela';

  @override
  String get installmentValue => 'Valor por parcela';

  @override
  String get installmentValueForm => 'Valor por parcela';

  @override
  String get firstInstallmentMonth => 'Mês da 1ª Parcela';

  @override
  String get titleHint => 'Ex: Salário, Aluguel, Supermercado...';

  @override
  String get amountHint => 'R\$ 0,00';

  @override
  String get endMonthOptional => 'Mês de Fim (opcional)';

  @override
  String get startMonthRequiredLabel => 'Mês de Início *';

  @override
  String get yearlyMonthRequiredLabel => 'Mês do Ano *';

  @override
  String get totalInstallmentsRequiredLabel => 'Total de Parcelas *';

  @override
  String get titleRequiredLabel => 'Título *';

  @override
  String get amountRequiredLabel => 'Valor *';

  @override
  String get categoryRequiredLabel => 'Categoria *';

  @override
  String get dashboardTransactions => 'Transações';

  @override
  String get adjusted => 'Ajustado';

  @override
  String get transactionDetails => 'Detalhes da Transação';

  @override
  String get editAction => 'Editar';

  @override
  String get adjustMonthlyValueAction => 'Ajustar valor deste mês';

  @override
  String get deleteAction => 'Excluir';

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

  @override
  String get settings => 'Configurações';

  @override
  String get appearance => 'Aparência';

  @override
  String get language => 'Idioma';

  @override
  String get currency => 'Moeda';

  @override
  String get retry => 'Tentar Novamente';

  @override
  String get darkMode => 'Modo Escuro';

  @override
  String get lightMode => 'Modo Claro';

  @override
  String get portuguese => 'Português';

  @override
  String get english => 'Inglês';

  @override
  String get brazilianReal => 'Real Brasileiro (R\$)';

  @override
  String get usDollar => 'Dólar Americano (\$)';

  @override
  String get euro => 'Euro (€)';

  @override
  String get selectPeriod => 'Selecionar Período';

  @override
  String get confirm => 'Confirmar';

  @override
  String get transactionDeletedSuccess => 'Transação excluída com sucesso!';

  @override
  String get transactionUpdatedSuccess => 'Transação atualizada com sucesso!';

  @override
  String adjustValue(String month, String year) {
    return 'Ajustar Valor - $month/$year';
  }

  @override
  String get removeAdjustment => 'Remover Ajuste';

  @override
  String get editTransaction => 'Editar Transação';

  @override
  String get back => 'Voltar';

  @override
  String get notFound => 'Não Encontrado';

  @override
  String get backToTransactions => 'Voltar às Transações';

  @override
  String get profile => 'Perfil';

  @override
  String get profileComingSoon => 'Perfil - Em breve!';

  @override
  String get logout => 'Sair';

  @override
  String get confirmLogout => 'Confirmar Saída';

  @override
  String get confirmLogoutMessage => 'Tem certeza que deseja sair da sua conta?\n\nVocê precisará fazer login novamente para acessar o app.';

  @override
  String get authErrorTitle => 'Erro de Autenticação';

  @override
  String get networkErrorTitle => 'Erro de Conexão';

  @override
  String get databaseErrorTitle => 'Erro de Banco de Dados';

  @override
  String get transactionErrorTitle => 'Erro de Transação';

  @override
  String get budgetErrorTitle => 'Erro de Orçamento';

  @override
  String get settingsErrorTitle => 'Erro de Configurações';

  @override
  String get validationErrorTitle => 'Erro de Validação';

  @override
  String get generalErrorTitle => 'Erro';

  @override
  String get userNotFoundError => 'Usuário não encontrado. Verifique seu email e tente novamente.';

  @override
  String get wrongPasswordError => 'Senha incorreta. Verifique sua senha e tente novamente.';

  @override
  String get emailAlreadyInUseError => 'Este email já está sendo usado por outra conta.';

  @override
  String get weakPasswordError => 'A senha deve ter pelo menos 6 caracteres.';

  @override
  String get invalidEmailError => 'O email informado não é válido.';

  @override
  String get userDisabledError => 'Esta conta foi desabilitada. Entre em contato com o suporte.';

  @override
  String get tooManyRequestsError => 'Muitas tentativas de login. Tente novamente em alguns minutos.';

  @override
  String get operationNotAllowedError => 'Operação não permitida. Verifique suas configurações.';

  @override
  String get invalidCredentialError => 'Credenciais inválidas. Verifique seus dados e tente novamente.';

  @override
  String get authenticationFailedError => 'Falha na autenticação. Tente novamente.';

  @override
  String get userDataNotFoundError => 'Dados do usuário não encontrados.';

  @override
  String get signUpFailedError => 'Falha ao criar conta. Tente novamente.';

  @override
  String get signOutFailedError => 'Erro ao fazer logout. Tente novamente.';

  @override
  String get getCurrentUserFailedError => 'Erro ao buscar dados do usuário.';

  @override
  String get networkError => 'Erro de conexão. Verifique sua internet e tente novamente.';

  @override
  String get connectionTimeoutError => 'Tempo limite de conexão esgotado. Tente novamente.';

  @override
  String get serverError => 'Erro no servidor. Tente novamente em alguns minutos.';

  @override
  String get noInternetConnectionError => 'Sem conexão com a internet. Verifique sua conexão.';

  @override
  String get firebaseError => 'Erro no serviço. Tente novamente em alguns minutos.';

  @override
  String get firestoreError => 'Erro no banco de dados. Tente novamente.';

  @override
  String get permissionDeniedError => 'Acesso negado. Verifique suas permissões.';

  @override
  String get documentNotFoundError => 'Documento não encontrado.';

  @override
  String get collectionNotFoundError => 'Coleção não encontrada.';

  @override
  String get transactionNotFoundError => 'Transação não encontrada.';

  @override
  String get transactionSaveFailedError => 'Erro ao salvar transação. Tente novamente.';

  @override
  String get transactionDeleteFailedError => 'Erro ao excluir transação. Tente novamente.';

  @override
  String get transactionUpdateFailedError => 'Erro ao atualizar transação. Tente novamente.';

  @override
  String get transactionLoadFailedError => 'Erro ao carregar transações. Tente novamente.';

  @override
  String get invalidTransactionDataError => 'Dados da transação inválidos.';

  @override
  String get budgetCalculationFailedError => 'Erro ao calcular orçamento. Tente novamente.';

  @override
  String get budgetDataInvalidError => 'Dados do orçamento inválidos.';

  @override
  String get settingsSaveFailedError => 'Erro ao salvar configurações. Tente novamente.';

  @override
  String get settingsLoadFailedError => 'Erro ao carregar configurações. Tente novamente.';

  @override
  String get validationError => 'Dados inválidos. Verifique os campos e tente novamente.';

  @override
  String get invalidDataError => 'Dados inválidos fornecidos.';

  @override
  String get requiredFieldMissingError => 'Campo obrigatório não preenchido.';

  @override
  String get unknownError => 'Erro desconhecido. Tente novamente ou entre em contato com o suporte.';

  @override
  String get dataParsingError => 'Erro ao processar dados. Tente novamente.';

  @override
  String get cacheError => 'Erro no cache. Tente novamente.';

  @override
  String get storageError => 'Erro no armazenamento. Tente novamente.';

  @override
  String get editProfile => 'Editar Perfil';

  @override
  String get changeName => 'Alterar Nome';

  @override
  String get changePassword => 'Alterar Senha';

  @override
  String get deleteAccount => 'Excluir Conta';

  @override
  String get currentName => 'Nome Atual';

  @override
  String get newName => 'Novo Nome';

  @override
  String get nameUpdatedSuccess => 'Nome atualizado com sucesso!';

  @override
  String get currentPassword => 'Senha Atual';

  @override
  String get newPassword => 'Nova Senha';

  @override
  String get confirmNewPassword => 'Confirmar Nova Senha';

  @override
  String get passwordUpdatedSuccess => 'Senha alterada com sucesso!';

  @override
  String get deleteAccountConfirmation => 'Excluir Conta Permanentemente';

  @override
  String get deleteAccountWarning => 'Esta ação é irreversível!\n\nTodos os seus dados serão permanentemente excluídos:\n• Transações\n• Configurações\n• Histórico financeiro\n\nTem certeza que deseja continuar?';

  @override
  String get enterCurrentPasswordToDelete => 'Digite sua senha atual para confirmar a exclusão:';

  @override
  String get accountDeletedSuccess => 'Conta excluída com sucesso!';

  @override
  String get incorrectPassword => 'Senha atual incorreta';

  @override
  String get passwordTooWeak => 'A senha deve conter pelo menos 8 caracteres, incluindo: 1 letra maiúscula, 1 letra minúscula e 1 caractere especial';

  @override
  String get passwordsDoNotMatch => 'As senhas não coincidem';

  @override
  String get nameRequired => 'Nome é obrigatório';

  @override
  String get nameMinLength => 'Nome deve ter pelo menos 2 caracteres';

  @override
  String get currentPasswordRequired => 'Senha atual é obrigatória';

  @override
  String get newPasswordRequired => 'Nova senha é obrigatória';

  @override
  String get confirmPasswordRequired => 'Confirmação de senha é obrigatória';

  @override
  String get updateName => 'Atualizar Nome';

  @override
  String get updatePassword => 'Atualizar Senha';

  @override
  String get deleteAccountAction => 'Excluir Conta';

  @override
  String get profileUpdatedError => 'Erro ao atualizar perfil';

  @override
  String get passwordUpdateError => 'Erro ao alterar senha';

  @override
  String get accountDeleteError => 'Erro ao excluir conta';

  @override
  String get reauthenticationRequired => 'É necessário confirmar sua identidade para esta ação';
}
