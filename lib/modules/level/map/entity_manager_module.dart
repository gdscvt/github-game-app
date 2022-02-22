import 'dart:collection';
import 'package:flame/components.dart';
import 'package:github_game/entities/entity_group.dart';

/// This module is responsible for handling groups of entities in the level.
class EntityManagerModule extends Component {
  /// The set of all entity groups.
  late final HashSet<EntityGroup> _groups;

  /// Returns the set of all entity groups.
  HashSet<EntityGroup> get groups => _groups;

  /// Initializes the module and the set of entity groups.
  EntityManagerModule() : _groups = HashSet();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _loadGroups();
    addAll(_groups);
  }

  /// Loads all entity groups and adds them to the set.
  void _loadGroups() {}
}
