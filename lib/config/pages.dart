import 'package:get/get.dart';

import '../app/bindings/module/details_binding.dart';
import '../app/bindings/module/home_binding.dart';
import '../app/bindings/module/onboard_binding.dart';
import '../app/modules/details/view/details_view.dart';
import '../app/modules/home/view/home_view.dart';
import '../app/modules/home/view/search_map.dart';
import '../app/modules/onboard/view/onboard_view.dart';

part 'routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.ONBOARD;

  static final routes = [
    GetPage(
      name: _Paths.ONBOARD,
      page: () => OnboardView(),
      binding: OnboardBinding(),
    ),
    GetPage(
        name: _Paths.HOME,
        page: () => HomeView(),
        binding: HomeBinding(),
        children: []),
    GetPage(
      name: _Paths.DETAILS,
      page: () => DetailsView(),
      binding: DetailsBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => SearchMap(),
      //binding: DetailsBinding(),
    ),
  ];
}
