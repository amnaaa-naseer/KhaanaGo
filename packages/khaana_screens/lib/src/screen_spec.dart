class ScreenSpec {
  const ScreenSpec({
    required this.id,
    required this.title,
    required this.role,
    required this.priority,
    required this.kind,
    required this.module,
    required this.family,
    required this.requirements,
    required this.stories,
    required this.tests,
    required this.ownerOnly,
    required this.clauses,
  });

  final String id;
  final String title;
  final String role;
  final String priority;
  final String kind;
  final String module;
  final String family;
  final String requirements;
  final String stories;
  final String tests;
  final bool ownerOnly;
  final List<String> clauses;
}
