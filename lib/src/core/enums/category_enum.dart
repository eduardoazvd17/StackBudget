import 'package:flutter/material.dart';
import 'package:stackbudget/src/core/core.dart';

enum CategoryEnum {
  salary('work', '#4CAF50', TransactionTypeEnum.income),
  freelance('laptop', '#2196F3', TransactionTypeEnum.income),
  investment('trending_up', '#FF9800', TransactionTypeEnum.income),
  bonus('star', '#FFC107', TransactionTypeEnum.income),
  giftIncome('card_giftcard', '#E91E63', TransactionTypeEnum.income),
  otherIncome('attach_money', '#607D8B', TransactionTypeEnum.income),

  housing('home', '#4CAF50', TransactionTypeEnum.expense),
  utilities('electrical_services', '#FF9800', TransactionTypeEnum.expense),
  groceries('local_grocery_store', '#8BC34A', TransactionTypeEnum.expense),
  transportation('directions_car', '#2196F3', TransactionTypeEnum.expense),
  insurance('security', '#9C27B0', TransactionTypeEnum.expense),
  healthcare('local_hospital', '#E91E63', TransactionTypeEnum.expense),

  dining('restaurant', '#FF5722', TransactionTypeEnum.expense),
  entertainment('movie', '#00BCD4', TransactionTypeEnum.expense),
  shopping('shopping_bag', '#795548', TransactionTypeEnum.expense),
  travel('flight', '#3F51B5', TransactionTypeEnum.expense),
  hobbies('palette', '#FF9800', TransactionTypeEnum.expense),
  fitness('fitness_center', '#4CAF50', TransactionTypeEnum.expense),
  beauty('face', '#E91E63', TransactionTypeEnum.expense),

  loans('account_balance', '#607D8B', TransactionTypeEnum.expense),
  creditCard('credit_card', '#2196F3', TransactionTypeEnum.expense),
  taxes('receipt', '#FF5722', TransactionTypeEnum.expense),
  fees('money_off', '#795548', TransactionTypeEnum.expense),

  education('school', '#9C27B0', TransactionTypeEnum.expense),
  books('menu_book', '#3F51B5', TransactionTypeEnum.expense),
  courses('play_lesson', '#00BCD4', TransactionTypeEnum.expense),

  childcare('child_care', '#E91E63', TransactionTypeEnum.expense),
  pets('pets', '#8BC34A', TransactionTypeEnum.expense),
  gifts('redeem', '#FF9800', TransactionTypeEnum.expense),

  charity('volunteer_activism', '#4CAF50', TransactionTypeEnum.expense),
  emergencyFund('savings', '#FF5722', TransactionTypeEnum.expense),
  other('category', '#9E9E9E', null);

  const CategoryEnum(this.iconName, this.color, this.type);

  final String iconName;

  final String color;

  final TransactionTypeEnum? type;

  String getDisplayName(BuildContext context) {
    switch (this) {
      case CategoryEnum.salary:
        return context.strings.categorySalary;
      case CategoryEnum.freelance:
        return context.strings.categoryFreelance;
      case CategoryEnum.investment:
        return context.strings.categoryInvestment;
      case CategoryEnum.bonus:
        return context.strings.categoryBonus;
      case CategoryEnum.giftIncome:
        return context.strings.categoryGiftIncome;
      case CategoryEnum.otherIncome:
        return context.strings.categoryOtherIncome;
      case CategoryEnum.housing:
        return context.strings.categoryHousing;
      case CategoryEnum.utilities:
        return context.strings.categoryUtilities;
      case CategoryEnum.groceries:
        return context.strings.categoryGroceries;
      case CategoryEnum.transportation:
        return context.strings.categoryTransportation;
      case CategoryEnum.insurance:
        return context.strings.categoryInsurance;
      case CategoryEnum.healthcare:
        return context.strings.categoryHealthcare;
      case CategoryEnum.dining:
        return context.strings.categoryDining;
      case CategoryEnum.entertainment:
        return context.strings.categoryEntertainment;
      case CategoryEnum.shopping:
        return context.strings.categoryShopping;
      case CategoryEnum.travel:
        return context.strings.categoryTravel;
      case CategoryEnum.hobbies:
        return context.strings.categoryHobbies;
      case CategoryEnum.fitness:
        return context.strings.categoryFitness;
      case CategoryEnum.beauty:
        return context.strings.categoryBeauty;
      case CategoryEnum.loans:
        return context.strings.categoryLoans;
      case CategoryEnum.creditCard:
        return context.strings.categoryCreditCard;
      case CategoryEnum.taxes:
        return context.strings.categoryTaxes;
      case CategoryEnum.fees:
        return context.strings.categoryFees;
      case CategoryEnum.education:
        return context.strings.categoryEducation;
      case CategoryEnum.books:
        return context.strings.categoryBooks;
      case CategoryEnum.courses:
        return context.strings.categoryCourses;
      case CategoryEnum.childcare:
        return context.strings.categoryChildcare;
      case CategoryEnum.pets:
        return context.strings.categoryPets;
      case CategoryEnum.gifts:
        return context.strings.categoryGifts;
      case CategoryEnum.charity:
        return context.strings.categoryCharity;
      case CategoryEnum.emergencyFund:
        return context.strings.categoryEmergencyFund;
      case CategoryEnum.other:
        return context.strings.categoryOther;
    }
  }

  static List<CategoryEnum> get incomeCategories =>
      values
          .where((category) => category.type == TransactionTypeEnum.income)
          .toList();

  static List<CategoryEnum> get expenseCategories =>
      values
          .where((category) => category.type == TransactionTypeEnum.expense)
          .toList();

  static List<CategoryEnum> get allCategories => values;

  static CategoryEnum fromString(String value) {
    return values.firstWhere(
      (category) => category.name == value,
      orElse: () => other,
    );
  }
}
