import 'package:get/get.dart';
import 'package:st/app/modules/bluetooth/bluetooth_device_page/bluetooth_device_page_binding.dart';
import 'package:st/app/modules/bluetooth/bluetooth_device_page/bluetooth_device_page_view.dart';
import 'package:st/app/modules/bluetooth/bluetooth_scan_page/bindings/bluetooth_scan_page_binding.dart';
import 'package:st/app/modules/bluetooth/bluetooth_scan_page/views/bluetooth_scan_page.dart';
import 'package:st/app/modules/component_detail_page/bindings/component_detail_page_binding.dart';
import 'package:st/app/modules/component_detail_page/views/component_detail_view.dart';
import 'package:st/app/modules/home/bindings/home_binding.dart';
import 'package:st/app/modules/home/views/home_view.dart';
import 'package:st/app/modules/link_mode/bluetooth/bluetooth_scan_classic_page/bluetooth_scan_classic_page/bluetooth_scan_classic_page_binding.dart';
import 'package:st/app/modules/link_mode/bluetooth/bluetooth_scan_classic_page/bluetooth_scan_classic_page/bluetooth_scan_classic_page_view.dart';
import 'package:st/app/modules/link_mode/bluetooth/bluetooth_scan_classic_server_page/bluetooth_scan_classic_server_page_binding.dart';
import 'package:st/app/modules/link_mode/bluetooth/bluetooth_scan_classic_server_page/bluetooth_scan_classic_server_page_view.dart';
import 'package:st/app/modules/link_mode/link_mode_select/link_mode_select_binding.dart';
import 'package:st/app/modules/link_mode/link_mode_select/link_mode_select_view.dart';
import 'package:st/app/modules/link_mode/wifi/wifi_binding.dart';
import 'package:st/app/modules/link_mode/wifi/wifi_view.dart';
import 'package:st/app/modules/ministry_mark/adas_params/adas_params_set/adas_params_set_binding.dart';
import 'package:st/app/modules/ministry_mark/adas_params/adas_params_set/adas_params_set_view.dart';
import 'package:st/app/modules/ministry_mark/alarm_sound/alarm_sound_set/alarm_sound_set_binding.dart';
import 'package:st/app/modules/ministry_mark/alarm_sound/alarm_sound_set/alarm_sound_set_view.dart';
import 'package:st/app/modules/ministry_mark/algorithm_mark/bindings/algorithm_mark_set_binding.dart';
import 'package:st/app/modules/ministry_mark/algorithm_mark/views/algorithm_mark_set_view.dart';
import 'package:st/app/modules/ministry_mark/apn_4g/apn_4g_set/apn_4g_set_binding.dart';
import 'package:st/app/modules/ministry_mark/apn_4g/apn_4g_set/apn_4g_set_view.dart';
import 'package:st/app/modules/ministry_mark/basic_parameter/basic_parameter_get/basic_parameter_get_binding.dart';
import 'package:st/app/modules/ministry_mark/basic_parameter/basic_parameter_get/basic_parameter_get_view.dart';
import 'package:st/app/modules/ministry_mark/basic_parameter/basic_parameter_set/basic_parameter_settings_binding.dart';
import 'package:st/app/modules/ministry_mark/basic_parameter/basic_parameter_set/basic_parameter_settings_view.dart';
import 'package:st/app/modules/ministry_mark/bsd_params/bsd_params_set/bsd_params_set_binding.dart';
import 'package:st/app/modules/ministry_mark/bsd_params/bsd_params_set/bsd_params_set_view.dart';
import 'package:st/app/modules/ministry_mark/car_params/car_params_get/car_params_get_binding.dart';
import 'package:st/app/modules/ministry_mark/car_params/car_params_get/car_params_get_view.dart';
import 'package:st/app/modules/ministry_mark/car_params/car_params_set/car_params_set_binding.dart';
import 'package:st/app/modules/ministry_mark/car_params/car_params_set/car_params_set_view.dart';
import 'package:st/app/modules/ministry_mark/data_record_file/data_record_file_get_binding.dart';
import 'package:st/app/modules/ministry_mark/data_record_file/data_record_file_get_view.dart';
import 'package:st/app/modules/ministry_mark/data_summary_test/data_summary_test_binding.dart';
import 'package:st/app/modules/ministry_mark/data_summary_test/data_summary_test_view.dart';
import 'package:st/app/modules/ministry_mark/driver_ic/driver_ic_get/driver_ic_get_binding.dart';
import 'package:st/app/modules/ministry_mark/driver_ic/driver_ic_get/driver_ic_get_view.dart';
import 'package:st/app/modules/ministry_mark/driver_ic/driver_ic_set/driver_ic_set_binding.dart';
import 'package:st/app/modules/ministry_mark/driver_ic/driver_ic_set/driver_ic_set_view.dart';
import 'package:st/app/modules/ministry_mark/dsm_params/dsm_params_set/dsm_params_set_binding.dart';
import 'package:st/app/modules/ministry_mark/dsm_params/dsm_params_set/dsm_params_set_view.dart';
import 'package:st/app/modules/ministry_mark/ministry_mark_page/bindings/ministry_mark_page_binding.dart';
import 'package:st/app/modules/ministry_mark/ministry_mark_page/views/ministry_mark_page_view.dart';
import 'package:st/app/modules/ministry_mark/phone_number/phone_number_get/phone_number_get_binding.dart';
import 'package:st/app/modules/ministry_mark/phone_number/phone_number_get/phone_number_get_view.dart';
import 'package:st/app/modules/ministry_mark/phone_number/phone_number_set/phone_number_set_binding.dart';
import 'package:st/app/modules/ministry_mark/phone_number/phone_number_set/phone_number_set_view.dart';
import 'package:st/app/modules/ministry_mark/platform_domain_name/platform_domain_name_get/platform_domain_name_get_binding.dart';
import 'package:st/app/modules/ministry_mark/platform_domain_name/platform_domain_name_get/platform_domain_name_get_view.dart';
import 'package:st/app/modules/ministry_mark/platform_domain_name/platform_domain_name_set/platform_domain_name_set_binding.dart';
import 'package:st/app/modules/ministry_mark/platform_domain_name/platform_domain_name_set/platform_domain_name_set_view.dart';
import 'package:st/app/modules/ministry_mark/platform_ip/platform_ip_get/platform_ip_get_binding.dart';
import 'package:st/app/modules/ministry_mark/platform_ip/platform_ip_get/platform_ip_get_view.dart';
import 'package:st/app/modules/ministry_mark/platform_ip/platform_ip_set/platform_ip_set_binding.dart';
import 'package:st/app/modules/ministry_mark/platform_ip/platform_ip_set/platform_ip_set_view.dart';
import 'package:st/app/modules/ministry_mark/recorder_life_cycle/recorder_life_cycle_get/recorder_life_cycle_get_binding.dart';
import 'package:st/app/modules/ministry_mark/recorder_life_cycle/recorder_life_cycle_get/recorder_life_cycle_get_view.dart';
import 'package:st/app/modules/ministry_mark/recorder_life_cycle/recorder_life_cycle_set/recorder_life_cycle_set_binding.dart';
import 'package:st/app/modules/ministry_mark/recorder_life_cycle/recorder_life_cycle_set/recorder_life_cycle_set_view.dart';
import 'package:st/app/modules/ministry_mark/recorder_params/recorder_params_set/recorder_params_set_binding.dart';
import 'package:st/app/modules/ministry_mark/recorder_params/recorder_params_set/recorder_params_set_view.dart';
import 'package:st/app/modules/ministry_mark/recorder_test/recorder_test_binding.dart';
import 'package:st/app/modules/ministry_mark/recorder_test/recorder_test_view.dart';
import 'package:st/app/modules/ministry_mark/self_test_status/self_test_status_get/self_test_status_get_binding.dart';
import 'package:st/app/modules/ministry_mark/self_test_status/self_test_status_get/self_test_status_get_view.dart';
import 'package:st/app/modules/ministry_mark/speed_type/speed_type_get/speed_type_get_binding.dart';
import 'package:st/app/modules/ministry_mark/speed_type/speed_type_get/speed_type_get_view.dart';
import 'package:st/app/modules/ministry_mark/speed_type/speed_type_set/speed_type_set_binding.dart';
import 'package:st/app/modules/ministry_mark/speed_type/speed_type_set/speed_type_set_view.dart';
import 'package:st/app/modules/ministry_mark/video_url/video_url_get/video_url_get_binding.dart';
import 'package:st/app/modules/ministry_mark/video_url/video_url_get/video_url_get_view.dart';
import 'package:st/app/modules/page_route_aware/bindings/page_route_aware_binding.dart';
import 'package:st/app/modules/page_route_aware/views/page_route_aware_view.dart';
import 'package:st/app/modules/test_code_page/bindings/test_code_page_binding.dart';
import 'package:st/app/modules/test_code_page/views/test_code_page_view.dart';
import 'package:st/app/modules/video_mark/video_mark_page/video_mark_page_binding.dart';
import 'package:st/app/modules/video_mark/video_mark_page/video_mark_page_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PAGE_ROUTE_AWARE,
      page: () => const PageRouteAwareView(),
      binding: PageRouteAwareBinding(),
    ),
    GetPage(
      name: _Paths.TEST_CODE_PAGE,
      page: () => const TestCodePageView(),
      binding: TestCodePageBinding(),
    ),
    GetPage(
      name: _Paths.COMPONENT_DETAIL_PAGE,
      page: () => const ComponentDetailView(),
      binding: ComponentDetailPageBinding(),
    ),
    GetPage(
      name: _Paths.BLUETOOTH_SCAN_PAGE,
      page: () => const BluetoothScanPage(),
      binding: BluetoothScanPageBinding(),
    ),
    GetPage(
      name: _Paths.BLUETOOTH_DEVICE_PAGE_VIEW,
      page: () => const BluetoothDevicePageView(),
      binding: BluetoothDevicePageBinding(),
    ),
    GetPage(
      name: _Paths.MINISTRY_MARK_PAGE,
      page: () => const MinistryMarkPageView(),
      binding: MinistryMarkPageBinding(),
    ),
    GetPage(
      name: _Paths.MINISTRY_MARK_BASIC_PARAMETER_SETTINGS_VIEW,
      page: () => const BasicParameterSettingsPage(),
      binding: BasicParameterSettingsBinding(),
    ),
    GetPage(
      name: _Paths.MINISTRY_MARK_VIDEO_MARK_PAGE_VIEW,
      page: () => const VideoMarkPageView(),
      binding: VideoMarkPageBinding(),
    ),
    GetPage(
      name: _Paths.MINISTRY_MARK_RECORDER_TEST,
      page: () => const RecorderTestPage(),
      binding: RecorderTestBinding(),
    ),
    GetPage(
      name: _Paths.MINISTRY_MARK_ALGORITHM_SETTING,
      page: () => const AlgorithmMarkSetPage(),
      binding: AlgorithmMarkSetBinding(),
    ),
    GetPage(
      name: _Paths.MINISTRY_MARK_BSD_PARAMS_SETTING,
      page: () => const BsdParamsSetPage(),
      binding: BsdParamsSetBinding(),
    ),
    GetPage(
      name: _Paths.MINISTRY_MARK_ADAS_PARAMS_SETTING,
      page: () => const AdasParamsSetPage(),
      binding: AdasParamsSetBinding(),
    ),
    GetPage(
      name: _Paths.MINISTRY_MARK_DSM_PARAMS_SETTING,
      page: () => const DsmParamsSetPage(),
      binding: DsmParamsSetBinding(),
    ),
    GetPage(
      name: _Paths.MINISTRY_MARK_PLATFORM_IP_SETTING,
      page: () => const PlatformIpSetPage(),
      binding: PlatformIpSetBinding(),
    ),
    GetPage(
      name: _Paths.MINISTRY_MARK_PLATFORM_IP_GET,
      page: () => const PlatformIpGetPage(),
      binding: PlatformIpGetBinding(),
    ),
    GetPage(
      name: _Paths.MINISTRY_MARK_BASIC_PARAMETER_GET_VIEW,
      page: () => const BasicParameterGetPage(),
      binding: BasicParameterGetBinding(),
    ),
    GetPage(
      name: _Paths.LINK_MODEL_SELECT,
      page: () => const LinkModeSelectPage(),
      binding: LinkModeSelectBinding(),
    ),
    GetPage(
      name: _Paths.LINK_MODEL_WIFI,
      page: () => const WifiPage(),
      binding: WifiBinding(),
    ),
    GetPage(
      name: _Paths.BLUETOOTH_SCAN_CLASSIC_PAGE,
      page: () => const BluetoothScanClassicPage(),
      binding: BluetoothScanClassicPageBinding(),
    ),
    GetPage(
      name: _Paths.BLUETOOTH_SCAN_CLASSIC_SERVER_PAGE,
      page: () => const BluetoothScanClassicServerPage(),
      binding: BluetoothScanClassicServerPageBinding(),
    ),
    GetPage(
      name: _Paths.MINISTRY_MARK_PHONE_NUMBER_SETTING,
      page: () => const PhoneNumberSetPage(),
      binding: PhoneNumberSetBinding(),
    ),
    GetPage(
      name: _Paths.MINISTRY_MARK_PHONE_NUMBER_GET,
      page: () => const PhoneNumberGetPage(),
      binding: PhoneNumberGetBinding(),
    ),
    GetPage(
      name: _Paths.MINISTRY_MARK_ALARM_SOUND_SETTING,
      page: () => const AlarmSoundSetPage(),
      binding: AlarmSoundSetBinding(),
    ),
    GetPage(
      name: _Paths.MINISTRY_MARK_CAR_PARAMS_GET,
      page: () => const CarParamsGetPage(),
      binding: CarParamsGetBinding(),
    ),
    GetPage(
      name: _Paths.MINISTRY_MARK_CAR_PARAMS_SET,
      page: () => const CarParamsSetPage(),
      binding: CarParamsSetBinding(),
    ),
    GetPage(
      name: _Paths.MINISTRY_MARK_RECORDER_LIFE_CYCLE_GET,
      page: () => const RecorderLifeCycleGetPage(),
      binding: RecorderLifeCycleGetBinding(),
    ),
    GetPage(
      name: _Paths.MINISTRY_MARK_RECORDER_LIFE_CYCLE_SET,
      page: () => const RecorderLifeCycleSetPage(),
      binding: RecorderLifeCycleSetBinding(),
    ),
    GetPage(
      name: _Paths.MINISTRY_MARK_DRIVER_IC_GET,
      page: () => const DriverIcGetPage(),
      binding: DriverIcGetBinding(),
    ),
    GetPage(
      name: _Paths.MINISTRY_MARK_DRIVER_IC_SET,
      page: () => const DriverIcSetPage(),
      binding: DriverIcSetBinding(),
    ),
    GetPage(
      name: _Paths.MINISTRY_MARK_RECORDER_LIFE_CYCLE_SET,
      page: () => const DriverIcSetPage(),
      binding: DriverIcSetBinding(),
    ),
    GetPage(
      name: _Paths.MINISTRY_MARK_PLATFORM_DOMAIN_NAME_GET,
      page: () => const PlatformDomainNameGetPage(),
      binding: PlatformDomainNameGetBinding(),
    ),
    GetPage(
      name: _Paths.MINISTRY_MARK_PLATFORM_DOMAIN_NAME_SET,
      page: () => const PlatformDomainNameSetPage(),
      binding: PlatformDomainNameSetBinding(),
    ),
    GetPage(
      name: _Paths.MINISTRY_MARK_SPEED_TYPE_GET,
      page: () => const SpeedTypeGetPage(),
      binding: SpeedTypeGetBinding(),
    ),
    GetPage(
      name: _Paths.MINISTRY_MARK_SPEED_TYPE_SET,
      page: () => const SpeedTypeSetPage(),
      binding: SpeedTypeSetBinding(),
    ),
    GetPage(
      name: _Paths.MINISTRY_MARK_SELF_TEST_STATUS_GET,
      page: () => const SelfTestStatusGetPage(),
      binding: SelfTestStatusGetBinding(),
    ),
    GetPage(
      name: _Paths.MINISTRY_MARK_VIDEO_URL_GET,
      page: () => const VideoUrlGetPage(),
      binding: VideoUrlGetBinding(),
    ),
    GetPage(
      name: _Paths.MINISTRY_MARK_RECORDER_PARAMS_SET,
      page: () => const RecorderParamsSetPage(),
      binding: RecorderParamsSetBinding(),
    ),
    GetPage(
      name: _Paths.MINISTRY_MARK_APN_4G_SET,
      page: () => const Apn4gSetPage(),
      binding: Apn4gSetBinding(),
    ),
    GetPage(
      name: _Paths.MINISTRY_DATA_SUMMARY_TEST,
      page: () => const DataSummaryTestPage(),
      binding: DataSummaryTestBinding(),
    ),
    GetPage(
      name: _Paths.MINISTRY_DATA_RECORD_FILE,
      page: () => const DataRecordFileGetPage(),
      binding: DataRecordFileGetBinding(),
    ),
  ];
}
