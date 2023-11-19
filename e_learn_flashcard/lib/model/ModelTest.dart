class Test {
  final String testName;
  final String testDescription;
  final DateTime testStart;
  final DateTime testEnd;
  final int duration;
  final String courseId;

  Test({
    required this.testName,
    required this.testDescription,
    required this.testStart,
    required this.testEnd,
    required this.duration,
    required this.courseId,
  });

  factory Test.fromJson(Map<String, dynamic> json) {
    return Test(
      testName: json['testName'] as String,
      testDescription: json['testDescription'] as String,
      testStart: DateTime.parse(json['testStart'] as String),
      testEnd: DateTime.parse(json['testEnd'] as String),
      duration: json['duration'] as int,
      courseId: json['courseId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'testName': testName,
      'testDescription': testDescription,
      'testStart': testStart.toIso8601String(),
      'testEnd': testEnd.toIso8601String(),
      'duration': duration,
      'courseId': courseId,
    };
  }
}
