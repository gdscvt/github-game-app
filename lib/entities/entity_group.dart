import 'dart:collection';
import 'package:flame/components.dart';
import 'package:python_game/entities/entity.dart';
import 'package:python_game/entities/groups/computer_group.dart';
import 'package:python_game/entities/groups/laser_group.dart';

/// This is a group of entity components.
abstract class EntityGroup<T extends Entity> extends Component {
  /// The unique id of this entity group
  late final String _id;

  /// Set of all entities in this group
  late final HashSet<T> _entities;

  /// Returns the unique id of this group.
  String get id => _id;

  /// Returns the set of all entities in this group.
  HashSet<T> get entities => _entities;

  /// Initializes the group with an empty set.
  EntityGroup(
      this._id, List<dynamic> entityJsons, Map<String, dynamic>? properties)
      : _entities = HashSet();

  /// This factory should be used to create the correct type of entity group
  /// from json data.
  factory EntityGroup.fromJson(Map<String, dynamic> json) {
    String id = json["id"];
    String type = json["type"];
    List<dynamic> entityJsons = json["entities"];
    Map<String, dynamic>? properties = json["properties"];

    EntityGroup group;
    switch (type) {
      case "COMPUTER":
        group = ComputerGroup(id, entityJsons, properties);
        break;
      default:
        group = LaserGroup(id, entityJsons, properties);
        break;
    }

    return group as EntityGroup<T>;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    addAll(_entities);
  }
}
