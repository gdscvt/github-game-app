import 'package:github_game/entities/entity_group.dart';
import 'package:github_game/entities/individuals/computer.dart';
import 'package:github_game/mixins/has_level_ref.dart';

class ComputerGroup extends EntityGroup<Computer> with HasLevelRef {
  ComputerGroup(
      String id, List<dynamic> entityJsons, Map<String, dynamic>? properties)
      : super(id, entityJsons, properties);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
  }
}
