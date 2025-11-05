class NumberFormatter {
  /// Formate un nombre avec des séparateurs de milliers
  /// Exemple: 1003 devient "1,003"
  static String formatNumber(dynamic number, {String locale = 'en'}) {
    if (number == null) return '0';
    
    // Convertir en num
    num numericValue;
    if (number is String) {
      numericValue = num.tryParse(number) ?? 0;
    } else if (number is int || number is double) {
      numericValue = number;
    } else {
      return '0';
    }
    
    // Formater avec séparateurs de milliers
    final String formatted;
    
    if (locale == 'fr') {
      // Format français : espace comme séparateur
      formatted = _formatWithSeparator(numericValue, ' ');
    } else {
      // Format anglais : virgule comme séparateur
      formatted = _formatWithSeparator(numericValue, ',');
    }
    
    return formatted;
  }
  
  /// Formate un nombre avec un séparateur personnalisé
  static String _formatWithSeparator(num number, String separator) {
    final String numberStr = number.toString();
    
    // Séparer partie entière et décimale
    final parts = numberStr.split('.');
    String integerPart = parts[0];
    final String decimalPart = parts.length > 1 ? '.${parts[1]}' : '';
    
    // Ajouter les séparateurs de milliers
    final StringBuffer buffer = StringBuffer();
    final int length = integerPart.length;
    
    for (int i = 0; i < length; i++) {
      final int digitIndex = length - i - 1;
      if (i > 0 && i % 3 == 0) {
        buffer.write(separator);
      }
      buffer.write(integerPart[digitIndex]);
    }
    
    // Inverser le résultat
    final String formattedInteger = buffer.toString().split('').reversed.join();
    
    return '$formattedInteger$decimalPart';
  }
  
  /// Formate un prix avec devise
  static String formatPrice(dynamic number, {String currency = 'XAF', String locale = 'en'}) {
    final formattedNumber = formatNumber(number, locale: locale);
    if (locale == 'fr') {
      return '$formattedNumber $currency';
    } else {
      return '$currency $formattedNumber';
    }
  }
  
  /// Formate un nombre avec suffixe (K, M, B)
  static String formatCompact(dynamic number, {String locale = 'en'}) {
    if (number == null) return '0';
    
    final num numericValue = number is String ? num.tryParse(number) ?? 0 : number;
    
    if (numericValue >= 1000000000) {
      return '${(numericValue / 1000000000).toStringAsFixed(1)}B';
    } else if (numericValue >= 1000000) {
      return '${(numericValue / 1000000).toStringAsFixed(1)}M';
    } else if (numericValue >= 1000) {
      return '${(numericValue / 1000).toStringAsFixed(1)}K';
    } else {
      return formatNumber(numericValue, locale: locale);
    }
  }
}