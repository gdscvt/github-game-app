import 'package:github_game/entities/entity_group.dart';
import 'package:github_game/entities/individuals/computer.dart';
import 'dart:collection';
import 'package:github_game/mixins/has_level_ref.dart';

class ComputerGroup extends EntityGroup<Computer> with HasLevelRef {
  late final HashSet<String> _repoPaths;
  late final String _repoDirectoryPath;

  ComputerGroup(
      String id, List<dynamic> entityJsons, Map<String, dynamic>? properties)
      : _repoPaths = HashSet(),
        super(id, entityJsons, properties) {
    if (properties?["repos"] != null) {
      List<dynamic> repos = properties!["repos"];

      for (Map<String, dynamic> repo in repos) {
        _repoPaths.add(repo["path"]);
      }
    }
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    _repoDirectoryPath = "assets/assets/levels/${level.id}/repos";

    for (String repoPath in _repoPaths) {
      print("$_repoDirectoryPath/$repoPath");
    }
  }
}
