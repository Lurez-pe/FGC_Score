import 'dart:math';

class ScoringModel {
  int barriers = 0;
  int freshwaterBiodiversity = 0;
  int marineBiodiversity = 0;
  int terrestrialBiodiversity = 0;
  String robotAPosition = 'LEVEL 4';
  String robotBPosition = 'LEVEL 4';
  String robotCPosition = 'LEVEL 4';
  int robotsBalanced = 6;

  // Multiplicadores basados en la posición del robot
  static const Map<String, double> robotMultipliers = {
    'Not on ROPE': 0.0,
    'LEVEL 1': 0.125,
    'LEVEL 2': 0.25,
    'LEVEL 3': 0.375,
    'LEVEL 4': 0.5,
  };

  // Puntos de cooperación
  static const Map<int, double> coopertitionPoints = {
    0: 0.0,
    1: 0.0,
    2: 0.0,
    3: 0.0,
    4: 0.0,
    5: 15.0,
    6: 30.0,
  };

  double calculateDistributionFactor() {
    final stdev = calculateStandardDeviation();
    
    if (stdev <= 1) return 1 / (1 + 0.0);     // 0 < σ ≤ 1
    if (stdev >= 10) return 1 / (1 + 1.0);    // 10 ≤ σ ≤ 60
    return 1 / (1 + 0.6667);                  // 1 < σ < 10
  }

  double calculateStandardDeviation() {
    final mean = (freshwaterBiodiversity + marineBiodiversity + terrestrialBiodiversity) / 3;
    final variance = 
      (pow(freshwaterBiodiversity - mean, 2) + 
       pow(marineBiodiversity - mean, 2) + 
       pow(terrestrialBiodiversity - mean, 2)) / 3;
    
    return sqrt(variance);
  }

  double calculateProtectionMultiplier() {
    final robotAMult = robotMultipliers[robotAPosition] ?? 0.0;
    final robotBMult = robotMultipliers[robotBPosition] ?? 0.0;
    final robotCMult = robotMultipliers[robotCPosition] ?? 0.0;
    
    return 1 + robotAMult + robotBMult + robotCMult;
  }

  int calculateTotalScore() {
    // Puntos de barrera (máximo 9)
    final barrierPoints = barriers > 9 ? 9 : barriers;
    
    // Puntos de biodiversidad (máximo 120)
    final biodiversityPoints = (freshwaterBiodiversity + marineBiodiversity + terrestrialBiodiversity).clamp(0, 120);
    
    // Factor de distribución
    final distributionFactor = calculateDistributionFactor();
    
    // Multiplicador de protección
    final protectionMultiplier = calculateProtectionMultiplier();
    
    // Puntos de cooperación
    final coopertition = coopertitionPoints[robotsBalanced.clamp(0, 6)] ?? 0.0;
    
    // Cálculo final
    final score = ((barrierPoints + (biodiversityPoints * distributionFactor)) * protectionMultiplier + coopertition);
    
    // Redondear hacia arriba
    return score.ceil();
  }
}