import 'package:python_game/entities/entity_group.dart';
import 'package:python_game/entities/individuals/laser.dart';
import 'package:python_game/level.dart';

/// This class represents a group of lasers that can be activated and
/// deactivated together.
class LaserGroup extends EntityGroup<Laser> {
  /// This map holds all the properties of this group loaded from the level.
  late final Map<String, dynamic>? _properties;

  /// This constructor parses the json data and creates the laser group.
  LaserGroup(String id, List<dynamic> entityJsons, this._properties)
      : super(id, entityJsons) {
    entities.addAll(
        entityJsons.map((json) => Laser(Position(json["x"], json["y"]))));
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    if (!(_properties?["active"] ?? true)) {
      deactivate();
    }
  }

  /// Activate all lasers in the group.
  void activate() {
    for (Laser laser in entities) {
      laser.activate();
    }
  }

  /// Deactivate all lasers in the group.
  void deactivate() {
    for (Laser laser in entities) {
      laser.deactivate();
    }
  }
}
