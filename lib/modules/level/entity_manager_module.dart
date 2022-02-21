import 'dart:collection';

import 'package:github_game/entities/entity_group.dart';
import 'package:github_game/mixins/has_level_ref.dart';
import 'package:flame/components.dart';

class EntityManagerModule extends Component with HasLevelRef {
  late final HashSet<EntityGroup> groups;

  EntityManagerModule() : groups = HashSet();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _loadGroups();
    addAll(groups);
  }

  void _loadGroups() {}
}
