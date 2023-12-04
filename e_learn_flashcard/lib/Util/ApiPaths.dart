class ApiPaths {
  static const String baseUrl = 'http://3.27.242.207/api';

  static String getLoginPath() {
    return '$baseUrl/Authentication/Login';
  }
  static String getLogoutPath() {
    return '$baseUrl/Authentication/Logout';
  }
  static String getChangePasswordPath() {
    return '$baseUrl/Authentication/ChangePassword';
  }
  // Định nghĩa đường dẫn cho lấy danh sách khóa học với phân trang
  static String getChooseRolePath() {
    return '$baseUrl/Authentication/RequestRole';
  }

  static String getCoursePath() {
    return '$baseUrl/Course';
  }
  static String getCourseIdPath(String id) {
    return '$baseUrl/Course/$id';
  }
  static String getCourseListPathByName(String key, int pageNumber, int pageSize) {
    return '$baseUrl/Course?CourseName=$key&PageNumber=$pageNumber&PageSize=$pageSize';
  }
  static String getCourseListPath(int pageNumber, int pageSize) {
    return '$baseUrl/Course?PageNumber=$pageNumber&PageSize=$pageSize';
  }
  static String getCourseListByTeacherIdPath(String teacherId) {
    return '$baseUrl/Course/GetByTeacherId/$teacherId';
  }
  static String getCourseListByTopicIdPath(String topicId) {
    return '$baseUrl/Course/GetByTopicId/$topicId';
  }
  static String getTopicListPath(int pageNumber, int pageSize) {
    return '$baseUrl/Topic?PageNumber=$pageNumber&PageSize=$pageSize';
  }
  static String getQuestionPath() {
    return '$baseUrl/Question';
  }
  static String getQuestionIdPath(String id) {
    return '$baseUrl/Question/$id';
  }
  static String getClassPath() {
    return '$baseUrl/Class';
  }
  static String getClassIdPath(String id) {
    return '$baseUrl/Class/$id';
  }
  static String getListClassPathByName(String key, int pageNumber, int pageSize) {
    return '$baseUrl/Class?ClassName=$key&PageNumber=$pageNumber&PageSize=$pageSize';
  }
  static String getStudentJoinClassPath() {
    return '$baseUrl/StudentJoinClass';
  }
  static String getListClassByIdStudentPath(String id) {
    return '$baseUrl/StudentJoinClass/GetClassByStudentId/$id';
  }
  static String GetStudentByClassIdPath(String id) {
    return '$baseUrl/StudentJoinClass/GetStudentByClassId/$id';
  }
  static String getListClassByIdTeacherPath(String id) {
    return '$baseUrl/Class/GetByTeacherId/$id';
  }
  static String getTestPath() {
    return '$baseUrl/Test';
  }
  static String getTestBySizePath(int pageNumber, int pageSize) {
    return '$baseUrl/Test?PageNumber=$pageNumber&PageSize=$pageSize';
  }
  static String getTestIdPath(String id) {
    return '$baseUrl/Test/$id';
  }
  static String getTestByUserIdPath(String id) {
    return '$baseUrl/Test/GetTestsByCreatedUserId/$id';
  }
  static String getTestByStudentIdPath(String id) {
    return '$baseUrl/StudentJoinTest/GetTestByStudentId/$id';
  }
  static String getCourseInClassPath() {
    return '$baseUrl/CourseInClass';
  }

  static String getStudentJoinTestPath() {
    return '$baseUrl/StudentJoinTest';
  }
  static String getTestAnswerPath() {
    return '$baseUrl/TestAnswer';
  }
  static String getFeedbackPath()
  {
    return '$baseUrl/Feedback';
  }
  static String getFeedbackByCourseIdPath(String id)
  {
    return '$baseUrl/Feedback/GetByCourseId/$id';
  }
}
