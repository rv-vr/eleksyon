import '../models/election_event.dart';
import 'package:flutter/material.dart';

final List<ElectionEvent> electionSchedule = [
  ElectionEvent(
    title: 'Candidate Registration Period',
    startDate: DateTime(2025, 7, 1),
    endDate: DateTime(2025, 7, 15),
    description: 'Submit applications to run for office.',
    icon: Icons.app_registration_rounded,
  ),
  ElectionEvent(
    title: 'Campaign Period Starts',
    startDate: DateTime(2025, 7, 16),
    description: 'Candidates may begin official campaigns.',
    icon: Icons.campaign_rounded,
  ),
  ElectionEvent(
    title: 'Voting Period',
    startDate: DateTime(2025, 9, 15, 9, 0),
    endDate: DateTime(2025, 9, 17, 17, 0),
    description: 'Cast your votes during this time.',
    icon: Icons.how_to_vote_rounded,
  ),
  ElectionEvent(
    title: 'Results Announcement',
    startDate: DateTime(2025, 9, 20),
    description: 'Official election results will be published.',
    icon: Icons.analytics_rounded,
  ),
];
