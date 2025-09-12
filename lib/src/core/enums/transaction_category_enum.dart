enum TransactionCategoryEnum {
  salary,
  freelance,
  investment,
  bonus,
  gift,
  otherIncome,

  housing,
  utilities,
  groceries,
  transportation,
  insurance,
  healthcare,

  dining,
  entertainment,
  shopping,
  travel,
  hobbies,
  fitness,
  beauty,

  loans,
  creditCard,
  taxes,
  fees,

  education,
  books,
  courses,

  childcare,
  pets,
  gifts,

  charity,
  emergencyFund,
  other;

  String get displayName {
    switch (this) {
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

      case TransactionCategoryEnum.loans:
        return 'Empréstimos';
      case TransactionCategoryEnum.creditCard:
        return 'Cartão de Crédito';
      case TransactionCategoryEnum.taxes:
        return 'Impostos';
      case TransactionCategoryEnum.fees:
        return 'Taxas';

      case TransactionCategoryEnum.education:
        return 'Educação';
      case TransactionCategoryEnum.books:
        return 'Livros';
      case TransactionCategoryEnum.courses:
        return 'Cursos';

      case TransactionCategoryEnum.childcare:
        return 'Cuidados Infantis';
      case TransactionCategoryEnum.pets:
        return 'Pets';
      case TransactionCategoryEnum.gifts:
        return 'Presentes';

      case TransactionCategoryEnum.charity:
        return 'Caridade';
      case TransactionCategoryEnum.emergencyFund:
        return 'Reserva de Emergência';
      case TransactionCategoryEnum.other:
        return 'Outros';
    }
  }

  static List<TransactionCategoryEnum> get incomeCategories => [
    salary,
    freelance,
    investment,
    bonus,
    gift,
    otherIncome,
  ];

  static List<TransactionCategoryEnum> get expenseCategories => [
    housing,
    utilities,
    groceries,
    transportation,
    insurance,
    healthcare,

    dining,
    entertainment,
    shopping,
    travel,
    hobbies,
    fitness,
    beauty,

    loans,
    creditCard,
    taxes,
    fees,

    education,
    books,
    courses,

    childcare,
    pets,
    gifts,

    charity,
    emergencyFund,
    other,
  ];

  String get iconName {
    switch (this) {
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

      case TransactionCategoryEnum.loans:
        return 'account_balance';
      case TransactionCategoryEnum.creditCard:
        return 'credit_card';
      case TransactionCategoryEnum.taxes:
        return 'receipt';
      case TransactionCategoryEnum.fees:
        return 'money_off';

      case TransactionCategoryEnum.education:
        return 'school';
      case TransactionCategoryEnum.books:
        return 'menu_book';
      case TransactionCategoryEnum.courses:
        return 'play_lesson';

      case TransactionCategoryEnum.childcare:
        return 'child_care';
      case TransactionCategoryEnum.pets:
        return 'pets';
      case TransactionCategoryEnum.gifts:
        return 'redeem';

      case TransactionCategoryEnum.charity:
        return 'volunteer_activism';
      case TransactionCategoryEnum.emergencyFund:
        return 'savings';
      case TransactionCategoryEnum.other:
        return 'category';
    }
  }
}
