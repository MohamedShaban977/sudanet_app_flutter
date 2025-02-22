class EndPoint {
  /// base Url
  static const String baseUrl = 'https://suda-net.com/api/';
  // static const String baseUrl = 'http://testapi.suda-net.com/api/';

  /// end Point Authentication
  static const String login = '${baseUrl}Account/Login';
  static const String register = '${baseUrl}Account/Register';
  static const String resetPassword = '${baseUrl}Account/ResetPassword';

  /// end Point Home
  static const String getSliders = '${baseUrl}Home/GetSliders';
  static const String getCategories = '${baseUrl}Home/GetCategories';
  static const String getCourses = '${baseUrl}Home/GetCourses';

  static const String getCoursesByCategoriesId =
      '${baseUrl}Course/GetByCategoryId';

  static const String getPublicCourseDetail =
      '${baseUrl}Course/GetPublicCourseDetail';
  static const String getAuthCourseDetail =
      '${baseUrl}Course/GetAuthCourseDetail';

  static const String getFreeCourseLecture =
      '${baseUrl}Lecture/GetFreeCourseLecture';
  static const String getAuthCourseLecture =
      '${baseUrl}Lecture/GetAuthCourseLecture';

  static const String buyCourse = '${baseUrl}Course/BuyCourse';

  static const String getAllCategory = '${baseUrl}Category/GetMyCategories';

  static const String getContactInfo = '${baseUrl}ContactInfo/Get';
  static const String getUserPersonalInfo =
      '${baseUrl}Profile/GetUserPersonalInfo';
  static const String saveUserPersonalInfo =
      '${baseUrl}Profile/SaveUserPersonalInfo';

  static const String changePassword = '${baseUrl}Profile/ChangePassword';
  static const String getUserCourses = '${baseUrl}Profile/GetUserCourses';

  static const String getExamReady = '${baseUrl}Exam/GetExamReady';
  static const String getHomeWorkReady = '${baseUrl}HomeWork/GetHomeWorkReady';
  static const String getExam = '${baseUrl}Exam/GetExam';
  static const String getHomeWork = '${baseUrl}HomeWork/GetHomeWork';
  static const String saveAnswer = '${baseUrl}Exam/SaveAnswer';
  static const String saveHomeWorkAnswer =
      '${baseUrl}HomeWork/SaveHomeWorkAnswer';
  static const String endExam = '${baseUrl}Exam/EndExam';
  static const String endHomeWork = '${baseUrl}HomeWork/EndHomeWork';
  static const String getStudentExamsBySubject =
      '${baseUrl}Exam/GetStudentExams';
  static const String getStudentExamNotifications =
      '${baseUrl}Exam/GetStudentExamNotifications';
  static const String getStudentHomeWorks =
      '${baseUrl}HomeWork/GetStudentHomeWorks';
  static const String getStudentFiles = '${baseUrl}Course/GetStudentFiles';
}
