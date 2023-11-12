class ApiPaths {
  static const String baseUrl = 'http://3.27.242.207/api';

  // Định nghĩa đường dẫn cho lấy danh sách khóa học với phân trang
  static String getCoursePath(String id) {
    return '$baseUrl/Course/$id';
  }
  static String getCourseListPath(int pageNumber, int pageSize) {
    return '$baseUrl/Course?PageNumber=$pageNumber&PageSize=$pageSize';
  }
  static String getCourseListByTeacherIdPath(String teacherId) {
    return '$baseUrl/Course/GetByTeacherId/$teacherId';
  }
  static String getTopicListPath(int pageNumber, int pageSize) {
    return '$baseUrl/Topic?PageNumber=$pageNumber&PageSize=$pageSize';
  }

}
