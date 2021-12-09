import 'package:firebase_analytics/firebase_analytics.dart';

setLogEvent(FirebaseAnalytics analytics) {
  analytics.logEvent(
      name: 'Gercekten_calsiyor',
      parameters: <String, dynamic> {
        'bool': true,
      }
  );
}

setCurrentScreen(FirebaseAnalytics analytics, String screenName, String screenClass) {
  analytics.setCurrentScreen(
    screenName: screenName,
    screenClassOverride: screenClass,
  );
}

setuserId(FirebaseAnalytics analytics, String userID) {
  analytics.setUserId(userID);
}