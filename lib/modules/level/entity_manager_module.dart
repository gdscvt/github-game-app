import 'dart:collection';
import 'package:flame/components.dart';
import 'package:python_game/entities/entity_group.dart';

/// This module is responsible for handling groups of entities in the level.
class EntityManagerModule extends Component {
  /// A map of all entity groups mapped by id.
  late final HashMap<String, EntityGroup> _groups;

  /// Returns the map of all entity groups mapped by id.
  HashMap<String, EntityGroup> get groups => _groups;

  /// Loads all entity groups and adds them to the map.
  EntityManagerModule(Iterable<EntityGroup> entityGroups)
      : _groups = HashMap() {
    for (EntityGroup group in entityGroups) {
      _groups.putIfAbsent(group.id, () => group);
    }
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    addAll(_groups.values);
  }
}
