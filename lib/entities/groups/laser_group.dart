import 'package:github_game/entities/entity_group.dart';
import 'package:github_game/entities/individuals/laser.dart';
import 'package:github_game/level.dart';

/// This class represents a group of lasers that can be activated and
/// deactivated together.
class LaserGroup extends EntityGroup<Laser> {
  /// This constructor parses the json data and creates the laser group.
  LaserGroup(List<dynamic> entityJsons, Map<String, dynamic> properties)
      : super(entityJsons, properties) {
    entities.addAll(
        entityJsons.map((json) => Laser(Position(json["x"], json["y"]))));

    if (!properties["active"]) {
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
