import 'package:batami/bindings/apartment_faults/add_apartment_fault_binding.dart';
import 'package:batami/bindings/apartment_faults/apartment_faults_binding.dart';
import 'package:batami/bindings/auth/forgot_password_binding.dart';
import 'package:batami/bindings/daily_attendance_binding.dart';
import 'package:batami/bindings/auth/login_binding.dart';
import 'package:batami/bindings/save_document_binding.dart';
import 'package:batami/ui/auth/forgot_password_screen.dart';
import 'package:batami/ui/auth/login_screen.dart';
import 'package:batami/ui/nav_screens/apartment_faults/add_apartment_fault_screen.dart';
import 'package:batami/ui/nav_screens/apartment_faults/apartment_faults_screen.dart';
import 'package:batami/ui/nav_screens/daily_attendance_screen.dart';
import 'package:batami/ui/nav_screens/save_document_screen.dart';
import 'package:get/get.dart';

final routes = [
  GetPage(name: '/login', page: () => const LoginScreen(), binding: LoginBinding()),
  GetPage(name: '/forgot_password', page: () => const ForgotPasswordScreen(), binding: ForgotPasswordBinding()),
  GetPage(name: '/daily_attendance', page: () => const DailyAttendanceScreen(), binding: DailyAttendanceBinding()),
  GetPage(name: '/save_document', page: () => SaveDocumentScreen(), binding: SaveDocumentBinding()),
  GetPage(name: '/apartment_faults', page: () => const ApartmentFaultsScreen(), binding: ApartmentFaultsBinding()),
  // GetPage(name: '/add_apartment_fault/:fault_details', page: () => AddApartmentFaultScreen(), binding: AddApartmentFaultBinding()),
  GetPage(name: '/add_apartment_fault', page: () => AddApartmentFaultScreen(), binding: AddApartmentFaultBinding()),
];