import 'package:github_game/entities/entity_group.dart';
import 'package:github_game/entities/individuals/computer.dart';
import 'package:github_game/mixins/has_level_ref.dart';

import '../../level.dart';

class ComputerGroup extends EntityGroup<Computer> with HasLevelRef {
  ComputerGroup(
      String id, List<dynamic> entityJsons, Map<String, dynamic>? properties)
      : super(id, entityJsons, properties) {
    entities.addAll(
        entityJsons.map((json) => Computer(Position(json["x"], json["y"]))));
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
  }
}
