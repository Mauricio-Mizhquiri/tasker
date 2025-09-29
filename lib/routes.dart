import 'package:geo_tasker/view/home_view.dart';
import 'package:geo_tasker/view/task_detail_view.dart';
import 'package:geo_tasker/view/task_form_view.dart';
import 'package:get/get.dart';


final routes = [
  GetPage(name: '/', page: () => HomeView()),
  GetPage(name: '/task_form', page: () => TaskFormView()),
  GetPage(name: '/task_detail/:id', page: () => TaskDetailView()),
];
