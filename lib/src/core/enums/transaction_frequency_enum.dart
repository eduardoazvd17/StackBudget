enum TransactionFrequencyEnum {
  oneTime, // Gasto único
  monthly, // Recorrente mensal
  customMonthly, // Recorrente mensal com meses específicos
  yearly, // Recorrente anual
  installment; // Parcelado

  String get displayName {
    switch (this) {
      case TransactionFrequencyEnum.oneTime:
        return 'Única';
      case TransactionFrequencyEnum.monthly:
        return 'Mensal';
      case TransactionFrequencyEnum.customMonthly:
        return 'Mensal Personalizado';
      case TransactionFrequencyEnum.yearly:
        return 'Anual';
      case TransactionFrequencyEnum.installment:
        return 'Parcelado';
    }
  }
}
