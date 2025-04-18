import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudanet_app_flutter/features/categories/presentation/screens/categories_screen.dart';
import 'package:sudanet_app_flutter/features/homworks/presentation/pages/written_homework_screen.dart';
import 'package:sudanet_app_flutter/features/profile/presentation/screens/profile_screen.dart';
import 'package:sudanet_app_flutter/features/subject_info/screens/subject_info_screen.dart';

import '../../app/injection_container.dart';

import '../../features/auth/login/presentation/cubit/login_cubit.dart';
import '../../features/auth/login/presentation/screens/login_screen.dart';
import '../../features/categories/presentation/cubit/categories_cubit.dart';
import '../../features/contact_info/presentation/cubit/contact_info_cubit.dart';
import '../../features/contact_info/presentation/screens/contact_info_screen.dart';
import '../../features/course_details/presentation/cubit/course_details_cubit.dart';
import '../../features/course_details/presentation/screens/course_details_screen.dart';
import '../../features/course_details/presentation/screens/course_lecture_details.dart';
import '../../features/courses_by_category/presentation/cubit/courses_by_category_cubit.dart';
import '../../features/courses_by_category/presentation/screens/corses_by_category_screen.dart';
import '../../features/exam/presentation/cubit/exam_cubit.dart';
import '../../features/exam/presentation/screens/exam_layout_screen.dart';
import '../../features/exam/presentation/screens/exam_screen.dart';
import '../../features/exams/presentation/cubit/exams_by_subject_cubit.dart';
import '../../features/exams/presentation/pages/exams_screen.dart';
import '../../features/homworks/presentation/cubit/homework_student_cubit.dart';
import '../../features/homworks/presentation/pages/homeworks_screen.dart';
import '../../features/profile/presentation/cubit/profile_cubit.dart';
import '../../features/profile/presentation/screens/change_password_screen.dart';
import '../../features/profile/presentation/screens/profile_info_edit_screen.dart';
import '../../features/profile/presentation/screens/user_my_courses_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../app_manage/strings_manager.dart';
import 'magic_router.dart';
import 'routes_name.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesNames.initialRoute:
        return MagicRouter.pageRoute(const SplashScreen());

      // loginRoute
      case RoutesNames.loginRoute:
        ServiceLocator.initLoginGetIt();
        return MagicRouter.pageRoute(BlocProvider(
          create: (context) => sl<LoginCubit>(),
          child: const LoginScreen(),
        ));

      case RoutesNames.homeCategoriesRoute:
        ServiceLocator.initCategoriesGetIt();
        ServiceLocator.initExamsBySubjectGetIt();
        return MagicRouter.pageRoute(MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => sl<CategoriesCubit>()..getCategories(),
            ),
            BlocProvider(
              create: (context) =>
                  sl<ExamsBySubjectCubit>()..getExamsNotification(),
            ),
          ],
          child: const CategoriesScreen(),
        ));

      case RoutesNames.profileRoute:
        ServiceLocator.initProfileGetIt();

        return MagicRouter.pageRoute(
          BlocProvider(
            create: (context) => sl<ContactInfoCubit>()..getContactInfo(),
            child: const ProfileScreen(),
          ),
        );

      case RoutesNames.coursesByCategoryScreen:
        ServiceLocator.initCoursesByCategoryGetIt();
        final args = settings.arguments as Map<String, dynamic>?;

        return MagicRouter.pageRoute(BlocProvider(
          create: (context) =>
              sl<CoursesByCategoryCubit>()..getCoursesByCategoryId(args?['id']),
          child: CoursesByCategoryScreen(
            categoryId: args?['id'],
            title: args?['title'],
          ),
        ));

      case RoutesNames.contactInfo:
        ServiceLocator.initGetContactInfoGetIt();
        return MagicRouter.pageRoute(BlocProvider(
          create: (context) => sl<ContactInfoCubit>()..getContactInfo(),
          child: const ContactInfoScreen(),
        ));

      case RoutesNames.courseDetails:
        ServiceLocator.initCoursesDetailsGetIt();
        final args = settings.arguments as Map<String, dynamic>?;
        return MagicRouter.pageRoute(BlocProvider(
          create: (context) =>
              sl<CourseDetailsCubit>()..getCourseDetails(args?['subject_id']),
          child: CourseDetailsScreen(id: args?['subject_id']),
        ));

      case RoutesNames.courseLectures:
        ServiceLocator.initCoursesDetailsGetIt();
        final res = settings.arguments! as Map<String, dynamic>;
        return MagicRouter.pageRoute(BlocProvider(
          create: (context) => sl<CourseDetailsCubit>(),
          child: CourseLecturesScreen(
            courseLectureDetails: res['courseLectures'],
            initVideoID: res['initVideoID'],
          ),
        ));

      case RoutesNames.profileInfoEditRoute:
        ServiceLocator.initProfileGetIt();
        return MagicRouter.pageRoute(BlocProvider(
          create: (context) => sl<ProfileCubit>()..getPersonalInfo(),
          child: const ProfileInfoEditScreen(),
        ));

      case RoutesNames.changePasswordRoute:
        ServiceLocator.initProfileGetIt();
        return MagicRouter.pageRoute(BlocProvider(
          create: (context) => sl<ProfileCubit>(),
          child: const ChangePasswordScreen(),
        ));

      case RoutesNames.userMyCoursesRoute:
        ServiceLocator.initProfileGetIt();
        return MagicRouter.pageRoute(BlocProvider(
          create: (context) => sl<ProfileCubit>()..getUserMyCourses(),
          child: const UserMyCoursesScreen(),
        ));

      case RoutesNames.examLayoutRoute:
        ServiceLocator.initExamGetIt();
        final args = settings.arguments as Map<String, dynamic>?;
        return MagicRouter.pageRoute(BlocProvider(
          create: (context) => sl<ExamCubit>()
            ..getExamReady(
              examId: args?['id'],
              type: args?['type'],
            ),
          child: ExamLayoutScreen(
            id: args?['id'],
            type: args?['type'],
          ),
        ));

      case RoutesNames.examRoute:
        ServiceLocator.initExamGetIt();
        final arge = settings.arguments as Map<String, dynamic>;
        return MagicRouter.pageRoute(
          BlocProvider(
            create: (context) => sl<ExamCubit>()
              ..getExamQuestionOrPercentage(
                examId: arge['id'],
                type: arge['type'],
              ),
            child: ExamScreen(
              id: arge['id'],
              type: arge['type'],
            ),
          ),
        );

      case RoutesNames.homeworksRoute:
        ServiceLocator.initHomeworksStudentGetIt();
        final arg = settings.arguments as Map<String, dynamic>?;
        return MagicRouter.pageRoute(
          BlocProvider(
            create: (context) => sl<HomeworkStudentCubit>()
              ..getHomeworkBySubject(arg?['subject_id']),
            child: HomeworksScreen(
              subjectId: arg?['subject_id'],
            ),
          ),
        );

      case RoutesNames.writtenHomeworkRoute:
        ServiceLocator.initHomeworksStudentGetIt();
        final arg = settings.arguments as Map<String, dynamic>?;
        return MagicRouter.pageRoute(
          BlocProvider(
            create: (context) => sl<HomeworkStudentCubit>()
              ..getWrittenHomeworkBySubject(arg?['subject_id']),
            child: WrittenHomeworkScreen(
              subjectId: arg?['subject_id'],
            ),
          ),
        );

      case RoutesNames.examsRoute:
        ServiceLocator.initExamsBySubjectGetIt();
        final arg = settings.arguments as Map<String, dynamic>?;
        return MagicRouter.pageRoute(
          BlocProvider(
            create: (context) => sl<ExamsBySubjectCubit>()
              ..getExamsBySubject(arg?['subject_id']),
            child: ExamsBySubjectScreen(subjectId: arg?['subject_id']),
          ),
        );

      case RoutesNames.subjectInfoRoute:
        final arg = settings.arguments as Map<String, dynamic>?;
        return MagicRouter.pageRoute(
          SubjectInfoScreen(
            subjectId: arg?['subject_id'],
            subjectName: arg?['subject_name'] as String,
            lecturesEnabled: arg?['lectures_enabled'] as bool,
            homeWorkEnabled: arg?['homework_enabled'] as bool,
            filesEnabled: arg?['files_enabled'] as bool,
            examsEnabled: arg?['exams_enabled'] as bool,
          ),
        );

      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MagicRouter.pageRoute(Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.noRouteFound),
      ),
      body: const Center(child: Text(AppStrings.noRouteFound)),
    ));
  }
}
