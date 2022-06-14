import 'package:batami/bindings/daily_attendance_binding.dart';
import 'package:batami/bindings/save_document_binding.dart';
import 'package:batami/helpers/custom_colors.dart';
import 'package:batami/helpers/utils.dart';
import 'package:batami/ui/nav_screens/daily_attendance_screen.dart';
import 'package:batami/ui/nav_screens/save_document_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerNavigation extends StatelessWidget {
  // DrawerNavigation();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: <Widget>[
        DrawerHeader(
          decoration: const BoxDecoration(color: CustomColors.colorSecondary),
          child: Center(
            child: Image.asset(
              'lib/assets/images/batami_logo.png',
              fit: BoxFit.fitHeight,
              height: 120.0,
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.white,
            child: ListView(
              shrinkWrap: true,
              children:
                  ListTile.divideTiles(color: CustomColors.colorMain, tiles: [
                ListTile(
                  leading: Image.asset(
                    "lib/assets/images/ic_personal_details.png",
                  ),
                  minLeadingWidth: 50.0,
                  title: Text('פרטים אישיים '),
                  onTap: () {},
                ),
                ListTile(
                  leading: Image.asset(
                    "lib/assets/images/ic_daily_attendance.png",
                  ),
                  minLeadingWidth: 50.0,
                  title: Text('דיווח שעות יומי'),
                  onTap: () {
                    // Get.off(() => DailyAttendanceScreen(),
                    //     binding: DailyAttendanceBinding());
                    Get.toNamed('/daily_attendance');
                  },
                ),
                ListTile(
                  leading: Image.asset(
                    "lib/assets/images/ic_attendance.png",
                  ),
                  minLeadingWidth: 50.0,
                  title: Text('נוכחות'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Image.asset(
                    "lib/assets/images/ic_documents.png",
                  ),
                  minLeadingWidth: 50.0,
                  title: Text('מסמכים'),
                  onTap: () {
                    // Get.off(() => SaveDocumentScreen(),
                    //     binding: SaveDocumentBinding());
                    Get.toNamed('/save_document');
                  },
                ),
                ListTile(
                  leading: Image.asset(
                    "lib/assets/images/ic_messages.png",
                  ),
                  minLeadingWidth: 50.0,
                  title: Text('הודעות'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Image.asset(
                    "lib/assets/images/ic_salary.png",
                  ),
                  minLeadingWidth: 50.0,
                  title: Text('דמי כיס'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Image.asset(
                    "lib/assets/images/ic_settings.png",
                  ),
                  minLeadingWidth: 50.0,
                  title: Text('שיבוץ'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Image.asset(
                    "lib/assets/images/ic_my_preferences.png",
                  ),
                  minLeadingWidth: 50.0,
                  title: Text('מועדפים שלי'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Image.asset(
                    "lib/assets/images/ic_tours.png",
                  ),
                  minLeadingWidth: 50.0,
                  title: Text('סיירות'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Image.asset(
                    "lib/assets/images/ic_sorting.png",
                  ),
                  minLeadingWidth: 50.0,
                  title: Text('מיונים'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Image.asset(
                    "lib/assets/images/ic_apartment.png",
                  ),
                  minLeadingWidth: 50.0,
                  title: Text('דירה'),
                  onTap: () {
                    Get.toNamed('/apartment_faults');},
                ),
                ListTile(
                  leading: Image.asset(
                    "lib/assets/images/ic_abroad.png",
                  ),
                  minLeadingWidth: 50.0,
                  title: Text('תפוצות'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.school_outlined,
                    color: CustomColors.colorIcons,
                  ),
                  minLeadingWidth: 50.0,
                  title: Text('מלגות'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: CustomColors.colorIcons,
                  ),
                  minLeadingWidth: 50.0,
                  title: Text('להתנתק'),
                  onTap: () => logoutAndGoToLogin(),
                ),
              ]).toList(),
            ),
          ),
        ),
      ]),
    );
  }
}
