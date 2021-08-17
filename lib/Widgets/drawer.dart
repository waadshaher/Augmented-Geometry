import 'package:argeometry/Widgets/home_page.dart';
import 'navdrawer.dart';

viewHome(bool val) {
  if (val) {
    return BodyLayoutStudent();
  } else if (!val) {
    return BodyLayoutTeacher();
  }
}

viewDrawer(bool val) {
  if (val) {
    return NavDrawer();
  } else if (!val) {
    return NavDrawerTeacher();
  }
}
