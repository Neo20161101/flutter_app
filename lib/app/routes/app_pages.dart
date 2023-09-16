import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/notFound/bindings/not_found_binding.dart';
import '../modules/notFound/views/not_found_view.dart';
import '../modules/tab2/bindings/tab2_binding.dart';
import '../modules/tab2/views/tab2_view.dart';
import '../tabBar/tab1.dart';
import '../tabBar/tab2.dart';
import '../tabBar/tab3.dart';
import '../tabBar/tab4.dart';
import '../tabBar/tab5.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.Tab1; // 如不要tabBar 可指定 HOME

  static final routes = [
    GetPage(
      name: _Paths.Tab1,
      page: () => const Tab1(),
      binding: HomeBinding(), // 针对展示哪个模块 就绑定哪个模块的控制器
    ),
    GetPage(
      name: _Paths.Tab2,
      page: () => const Tab2(),
      binding: NotFoundBinding(),
    ),
    GetPage(
      name: _Paths.Tab3,
      page: () => const Tab3(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.Tab4,
      page: () => const Tab4(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.Tab5,
      page: () => const Tab5(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.NOT_FOUND,
      page: () => const NotFoundView(),
      binding: NotFoundBinding(),
    ),
    GetPage(
      name: _Paths.TAB2,
      page: () => const Tab2View(),
      binding: Tab2Binding(),
    ),
  ];
}
