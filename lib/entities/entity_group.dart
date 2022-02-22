import 'dart:collection';
import 'package:flame/components.dart';
import 'package:github_game/entity.dart';

/// This is a group of entity components.
abstract class EntityGroup<T extends Entity> extends Component {
  /// Set of all entities in this group
  late final HashSet<T> _entities;

  /// Returns the set of all entities in this group
  HashSet<T> get entities => _entities;

  /// Initializes the group with an empty set.
  EntityGroup() : _entities = HashSet();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    loadEntities();
    addAll(_entities);
  }

  /// Loads all entities in this group.
  void loadEntities();
}
