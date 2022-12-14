import 'package:get/get.dart';
import 'package:st/app/modules/app_tab_bar.dart';
import 'package:st/app/modules/jobs/completed_job/bindings/completed_job_binding.dart';
import 'package:st/app/modules/jobs/completed_job/views/completed_job_view.dart';
import 'package:st/app/modules/jobs/job_details/bindings/jobs_job_details_binding.dart';
import 'package:st/app/modules/jobs/job_details/views/jobs_job_details_view.dart';
import 'package:st/app/modules/jobs/replenishment_job/bindings/replenishment_job_binding.dart';
import 'package:st/app/modules/jobs/replenishment_job/views/replenishment_job_view.dart';
import 'package:st/app/modules/jobs/start_job_page/bindings/start_job_page_binding.dart';
import 'package:st/app/modules/jobs/start_job_page/views/start_job_page_view.dart';
import 'package:st/app/modules/jobs/underway_job/bindings/underway_job_binding.dart';
import 'package:st/app/modules/jobs/underway_job/views/underway_job_view.dart';
import 'package:st/app/modules/login_page/bindings/login_page_binding.dart';
import 'package:st/app/modules/login_page/views/login_page_view.dart';
import 'package:st/app/modules/query_site/bindings/query_site_binding.dart';
import 'package:st/app/modules/query_site/views/query_site_view.dart';
import 'package:st/app/modules/query_site_number/bindings/query_site_number_binding.dart';
import 'package:st/app/modules/query_site_number/views/query_site_number_view.dart';
import 'package:st/app/modules/query_work_face/bindings/query_work_face_binding.dart';
import 'package:st/app/modules/query_work_face/views/query_work_face_view.dart';
import 'package:st/app/modules/splash/bindings/splash_binding.dart';
import 'package:st/app/modules/splash/views/splash_view.dart';
import 'package:st/app/modules/user_profile/views/user_profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const AppTabBar(),
    ),
    GetPage(
      name: _Paths.LOGIN_PAGE,
      page: () => const LoginPageView(),
      binding: LoginPageBinding(),
    ),
    GetPage(
      name: _Paths.USER_PROFILE,
      page: () => const UserProfileView(),
    ),
    GetPage(
      name: _Paths.START_JOB_PAGE,
      page: () => const StartJobPageView(),
      binding: StartJobPageBinding(),
    ),
    GetPage(
      name: _Paths.REPLENISHMENT_JOB,
      page: () => const ReplenishmentJobView(),
      binding: ReplenishmentJobBinding(),
    ),
    GetPage(
      name: _Paths.COMPLETED_JOB,
      page: () => const CompletedJobView(),
      binding: CompletedJobBinding(),
    ),
    GetPage(
      name: _Paths.UNDERWAY_JOB,
      page: () => const UnderwayJobView(),
      binding: UnderwayJobBinding(),
    ),
    GetPage(
      name: _Paths.JOBS_JOB_DETAILS,
      page: () => const JobsJobDetailsView(),
      binding: JobsJobDetailsBinding(),
    ),
    GetPage(
      name: _Paths.QUERY_WORK_FACE,
      page: () => const QueryWorkFaceView(),
      binding: QueryWorkFaceBinding(),
    ),
    GetPage(
      name: _Paths.QUERY_SITE,
      page: () => const QuerySiteView(),
      binding: QuerySiteBinding(),
    ),
    GetPage(
      name: _Paths.QUERY_SITE_NUMBER,
      page: () => const QuerySiteNumberView(),
      binding: QuerySiteNumberBinding(),
    ),
  ];
}
