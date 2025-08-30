enum TransactionCategoryEnum {
  // Receitas
  salary,
  freelance,
  investment,
  bonus,
  gift,
  otherIncome,

  // Despesas - Essenciais
  housing,
  utilities,
  groceries,
  transportation,
  insurance,
  healthcare,

  // Despesas - Lifestyle
  dining,
  entertainment,
  shopping,
  travel,
  hobbies,
  fitness,
  beauty,

  // Despesas - Financeiras
  loans,
  creditCard,
  taxes,
  fees,

  // Despesas - Educação e Desenvolvimento
  education,
  books,
  courses,

  // Despesas - Família
  childcare,
  pets,
  gifts,

  // Outros
  charity,
  emergencyFund,
  other;

  String get displayName {
    switch (this) {
      // Receitas
      case TransactionCategoryEnum.salary:
        return 'Salário';
      case TransactionCategoryEnum.freelance:
        return 'Freelance';
      case TransactionCategoryEnum.investment:
        return 'Investimentos';
      case TransactionCategoryEnum.bonus:
        return 'Bônus';
      case TransactionCategoryEnum.gift:
        return 'Presente Recebido';
      case TransactionCategoryEnum.otherIncome:
        return 'Outras Receitas';

      // Despesas - Essenciais
      case TransactionCategoryEnum.housing:
        return 'Moradia';
      case TransactionCategoryEnum.utilities:
        return 'Contas Básicas';
      case TransactionCategoryEnum.groceries:
        return 'Mercado';
      case TransactionCategoryEnum.transportation:
        return 'Transporte';
      case TransactionCategoryEnum.insurance:
        return 'Seguros';
      case TransactionCategoryEnum.healthcare:
        return 'Saúde';

      // Despesas - Lifestyle
      case TransactionCategoryEnum.dining:
        return 'Restaurantes';
      case TransactionCategoryEnum.entertainment:
        return 'Entretenimento';
      case TransactionCategoryEnum.shopping:
        return 'Compras';
      case TransactionCategoryEnum.travel:
        return 'Viagens';
      case TransactionCategoryEnum.hobbies:
        return 'Hobbies';
      case TransactionCategoryEnum.fitness:
        return 'Academia/Esportes';
      case TransactionCategoryEnum.beauty:
        return 'Beleza';

      // Despesas - Financeiras
      case TransactionCategoryEnum.loans:
        return 'Empréstimos';
      case TransactionCategoryEnum.creditCard:
        return 'Cartão de Crédito';
      case TransactionCategoryEnum.taxes:
        return 'Impostos';
      case TransactionCategoryEnum.fees:
        return 'Taxas';

      // Despesas - Educação e Desenvolvimento
      case TransactionCategoryEnum.education:
        return 'Educação';
      case TransactionCategoryEnum.books:
        return 'Livros';
      case TransactionCategoryEnum.courses:
        return 'Cursos';

      // Despesas - Família
      case TransactionCategoryEnum.childcare:
        return 'Cuidados Infantis';
      case TransactionCategoryEnum.pets:
        return 'Pets';
      case TransactionCategoryEnum.gifts:
        return 'Presentes';

      // Outros
      case TransactionCategoryEnum.charity:
        return 'Caridade';
      case TransactionCategoryEnum.emergencyFund:
        return 'Reserva de Emergência';
      case TransactionCategoryEnum.other:
        return 'Outros';
    }
  }

  /// Retorna as categorias mais apropriadas para receitas
  static List<TransactionCategoryEnum> get incomeCategories => [
    salary,
    freelance,
    investment,
    bonus,
    gift,
    otherIncome,
  ];

  /// Retorna as categorias mais apropriadas para despesas
  static List<TransactionCategoryEnum> get expenseCategories => [
    // Essenciais
    housing,
    utilities,
    groceries,
    transportation,
    insurance,
    healthcare,

    // Lifestyle
    dining,
    entertainment,
    shopping,
    travel,
    hobbies,
    fitness,
    beauty,

    // Financeiras
    loans,
    creditCard,
    taxes,
    fees,

    // Educação
    education,
    books,
    courses,

    // Família
    childcare,
    pets,
    gifts,

    // Outros
    charity,
    emergencyFund,
    other,
  ];

  /// Retorna ícone sugerido para a categoria
  String get iconName {
    switch (this) {
      // Receitas
      case TransactionCategoryEnum.salary:
        return 'work';
      case TransactionCategoryEnum.freelance:
        return 'laptop';
      case TransactionCategoryEnum.investment:
        return 'trending_up';
      case TransactionCategoryEnum.bonus:
        return 'star';
      case TransactionCategoryEnum.gift:
        return 'card_giftcard';
      case TransactionCategoryEnum.otherIncome:
        return 'attach_money';

      // Despesas - Essenciais
      case TransactionCategoryEnum.housing:
        return 'home';
      case TransactionCategoryEnum.utilities:
        return 'electrical_services';
      case TransactionCategoryEnum.groceries:
        return 'local_grocery_store';
      case TransactionCategoryEnum.transportation:
        return 'directions_car';
      case TransactionCategoryEnum.insurance:
        return 'security';
      case TransactionCategoryEnum.healthcare:
        return 'local_hospital';

      // Despesas - Lifestyle
      case TransactionCategoryEnum.dining:
        return 'restaurant';
      case TransactionCategoryEnum.entertainment:
        return 'movie';
      case TransactionCategoryEnum.shopping:
        return 'shopping_bag';
      case TransactionCategoryEnum.travel:
        return 'flight';
      case TransactionCategoryEnum.hobbies:
        return 'palette';
      case TransactionCategoryEnum.fitness:
        return 'fitness_center';
      case TransactionCategoryEnum.beauty:
        return 'face';

      // Despesas - Financeiras
      case TransactionCategoryEnum.loans:
        return 'account_balance';
      case TransactionCategoryEnum.creditCard:
        return 'credit_card';
      case TransactionCategoryEnum.taxes:
        return 'receipt';
      case TransactionCategoryEnum.fees:
        return 'money_off';

      // Despesas - Educação
      case TransactionCategoryEnum.education:
        return 'school';
      case TransactionCategoryEnum.books:
        return 'menu_book';
      case TransactionCategoryEnum.courses:
        return 'play_lesson';

      // Despesas - Família
      case TransactionCategoryEnum.childcare:
        return 'child_care';
      case TransactionCategoryEnum.pets:
        return 'pets';
      case TransactionCategoryEnum.gifts:
        return 'redeem';

      // Outros
      case TransactionCategoryEnum.charity:
        return 'volunteer_activism';
      case TransactionCategoryEnum.emergencyFund:
        return 'savings';
      case TransactionCategoryEnum.other:
        return 'category';
    }
  }
}
