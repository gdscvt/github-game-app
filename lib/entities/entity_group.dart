import 'dart:collection';
import 'package:flame/components.dart';
import 'package:github_game/entity.dart';
import 'package:github_game/mixins/has_level_ref.dart';

class EntityGroup<T extends Entity> extends Component with HasLevelRef {
  late final HashSet<T> entities;

  EntityGroup() : entities = HashSet();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _loadEntities();
    addAll(entities);
  }

  void _loadEntities() {}
}
