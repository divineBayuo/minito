import 'package:flutter/widgets.dart';

class MeetingDetailScreen extends StatefulWidget {
  String meetingId;
  MeetingDetailScreen({super.key, required this.meetingId});

  @override
  State<MeetingDetailScreen> createState() => _MeetingDetailScreenState();
}

class _MeetingDetailScreenState extends State<MeetingDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
