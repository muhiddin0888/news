import 'package:flutter/widgets.dart';

import '../../data/models/notification/news_model.dart';

@immutable
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class GetNotificationProgress extends NotificationState {}

class GetNotificationInSuccess extends NotificationState {
  GetNotificationInSuccess({required this.news});

  final List<CachedNews> news;
}

class GetNotificationInFailure extends NotificationState {
  final String errorText;
  GetNotificationInFailure({required this.errorText});
}



