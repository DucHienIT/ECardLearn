class ApiPaths {
  static const String baseUrl = 'http://3.27.242.207/api';
  static const String openApiUrl = "https://api.openai.com/v1/chat/completions";

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
  static String getLockUserPath(String mail) {
    return '$baseUrl/Authentication/LockUser?email=$mail';
  }
  static String getUnlockUserPath(String mail) {
    return '$baseUrl/Authentication/UnlockUser?email=$mail';
  }
  static String getAdminSetRolePath(String mail, String role) {
    return '$baseUrl/Authentication/AdminSetRole?email=$mail&roleName=$role';
  }
  static String getAdminRemoveRolePath(String mail, String role) {
    return '$baseUrl/Authentication/AdminRemoveRole?email=$mail&roleName=$role';
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
  static String getStudentJoinClassIdPath(String id) {
    return '$baseUrl/StudentJoinClass/$id';
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
  static String getTestSummaryByTestIdPath(String id) {
    return '$baseUrl/Test/SummaryReport?TestId=$id';
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
  static String getUser(String name, String email){
    return '$baseUrl/User/FindUser?name=$name&email=$email';
  }
  static String getNotificationPath(){
    return '$baseUrl/Notification';
  }
  static String getNotificationByClassPath(String id){
    return '$baseUrl/Notification/GetByClassId/$id';
  }
  static String getListAchivementPath(int numer, int size){
    return '$baseUrl/Achievement?PageNumber=$numer&PageSize=$size';
  }
}
