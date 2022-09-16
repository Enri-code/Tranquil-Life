import 'package:tranquil_life/core/constants/moods.dart';
import 'package:tranquil_life/features/journal/domain/entities/saved_note.dart';

final notes = [
  SavedNote(
    id: '7',
    title: 'I never liked therapy, so I was jittery, but my first',
    description: 'Description',
    emoji: moods[0],
    hexColor: '#ffC0E2C9',
    dateUpdated: DateTime.now(),
  ),
  SavedNote(
    id: '6',
    title:
        'I never liked therapy, so I was jittery, but my first session. This is how I felt before, during, and after my first session.',
    description: 'Long description',
    emoji: moods[1],
    dateUpdated: DateTime.now().add(const Duration(days: 1)),
  ),
  SavedNote(
    id: '0',
    title: 'Short note',
    description: 'Description',
    dateUpdated: DateTime.now(),
  ),
  SavedNote(
    id: '1',
    title:
        'I never liked therapy, so I was jittery, but my first session changed everything. This is how I felt before, during, and after my first session.',
    description: 'Long description',
    hexColor: '#ffA1D4AE',
    dateUpdated: DateTime.now(),
  ),
  SavedNote(
    id: '2',
    title: 'Short note',
    description: 'Description',
    dateUpdated: DateTime.now().subtract(const Duration(days: 2)),
    emoji: moods[4],
    hexColor: '#ffC0E2C9',
  ),
  SavedNote(
    id: '3',
    title: 'Short note',
    description: 'Description',
    dateUpdated: DateTime.now().subtract(const Duration(days: 2)),
  ),
  SavedNote(
    id: '4',
    title:
        'I never liked therapy, so I was jittery, but my first session changed everything. This is how I felt before, during, and after my first session.',
    description: 'Long description',
    dateUpdated: DateTime.now().subtract(const Duration(days: 3)),
    hexColor: '#ffC0E2C9',
  ),
];
