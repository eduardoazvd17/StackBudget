enum TransactionFrequencyEnum {
  oneTime, // Gasto único/variável
  monthly, // Recorrente mensal
  yearly, // Recorrente anual
  installment; // Parcelado

  String get displayName {
    switch (this) {
      case TransactionFrequencyEnum.oneTime:
        return 'Único';
      case TransactionFrequencyEnum.monthly:
        return 'Mensal';
      case TransactionFrequencyEnum.yearly:
        return 'Anual';
      case TransactionFrequencyEnum.installment:
        return 'Parcelado';
    }
  }
}
