import 'package:flutter/material.dart';

class ElectionEvent {
  final String title;
  final DateTime startDate;
  final DateTime? endDate;
  final String description;
  final IconData icon;

  ElectionEvent({
    required this.title,
    required this.startDate,
    this.endDate,
    required this.description,
    required this.icon,
  });
}