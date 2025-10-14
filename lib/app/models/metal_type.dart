enum MetalType {
  gold,
  silver,
  platinum,
  roseGold,
}

extension MetalTypeExtension on MetalType {
  String get displayName {
    switch (this) {
      case MetalType.gold:
        return 'Gold';
      case MetalType.silver:
        return 'Silver';
      case MetalType.platinum:
        return 'Platinum';
      case MetalType.roseGold:
        return 'Rose Gold';
    }
  }

  String get value {
    switch (this) {
      case MetalType.gold:
        return 'gold';
      case MetalType.silver:
        return 'silver';
      case MetalType.platinum:
        return 'platinum';
      case MetalType.roseGold:
        return 'rose_gold';
    }
  }

  static MetalType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'gold':
        return MetalType.gold;
      case 'silver':
        return MetalType.silver;
      case 'platinum':
        return MetalType.platinum;
      case 'rose_gold':
        return MetalType.roseGold;
      default:
        return MetalType.gold;
    }
  }
}
