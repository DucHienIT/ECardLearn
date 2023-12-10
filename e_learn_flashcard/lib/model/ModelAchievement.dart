class Achievement {
  final String achievementId;
  final String achievementName;
  final String achievementDescription;
  final int dayRequirement;

  Achievement({
    required this.achievementId,
    required this.achievementName,
    required this.achievementDescription,
    required this.dayRequirement,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      achievementId: json['achievementId'] as String,
      achievementName: json['achievementName'] as String,
      achievementDescription: json['achievementDescription'] as String,
      dayRequirement: json['dayRequirement'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'achievementId': achievementId,
      'achievementName': achievementName,
      'achievementDescription': achievementDescription,
      'dayRequirement': dayRequirement,
    };
  }
}
