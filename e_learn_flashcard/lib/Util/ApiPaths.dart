class ApiPaths {
  static const String baseUrl = 'http://3.27.242.207/api';

  static String getLoginPath() {
    return '$baseUrl/Authentication/Login';
  }
  static String getLogoutPath() {
    return '$baseUrl/Authentication/Logout';
  }
  // Định nghĩa đường dẫn cho lấy danh sách khóa học với phân trang
  static String getChooseRolePath() {
    return '$baseUrl/Authentication/RequestRole';
  }

  static String getCoursePath(String id) {
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
  static String getListClassByIdStudentPath(String id) {
    return '$baseUrl/StudentJoinClass/GetClassByStudentId/$id';
  }
  static String getListClassByIdTeacherPath(String id) {
    return '$baseUrl/Class/GetByTeacherId/$id';
  }
}
