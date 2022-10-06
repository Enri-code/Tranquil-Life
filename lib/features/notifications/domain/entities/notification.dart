class NotificationType {
  final String _type;
  const NotificationType._(this._type);

  static const message = NotificationType._('message');
  static const meeting = NotificationType._('meeting');
  static const contact = NotificationType._('contact');
  static const notification = NotificationType._('notification');

  @override
  String toString() => _type;

  static NotificationType fromValue(String type) {
    switch (type) {
      case 'message':
        return message;
      case 'meeting':
        return meeting;
      case 'contact':
        return contact;
      default:
        return notification;
    }
  }
}

class NotificationData {
  final String? fromUid;
  final NotificationType type;
  final DateTime creationTime;

  const NotificationData({
    this.fromUid,
    this.type = NotificationType.notification,
    required this.creationTime,
  });
}
