import 'package:flutter/material.dart';

import '../../../results/presentation/screens/result_list_screen.dart';
import '../../domain/entities/pathfind_result.dart';
import '../widgets/calculating_data.dart';
import '../providers/repository_provider.dart';

class ProcessScreen extends StatelessWidget {
  const ProcessScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("Process Screen")),
    body: Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: const _ProcessScreenBody(),
    ),
  );
}

class _ProcessScreenBody extends StatefulWidget {
  const _ProcessScreenBody();

  @override
  State<StatefulWidget> createState() => _ProcessScreenBodyState();
}

class _ProcessScreenBodyState extends State<_ProcessScreenBody> {
  final ValueNotifier<List<PathfindResult>?> resultsVn = ValueNotifier(null);
  final ValueNotifier<bool> isLoadingVn = ValueNotifier(false);

  void _handleCalculatingDone(List<PathfindResult> list) {
    resultsVn.value = list;
  }

  @override
  void dispose() {
    resultsVn.dispose();
    isLoadingVn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: .max,
      mainAxisAlignment: .end,
      children: [
        const Spacer(),
        CalculatingData(onCalculatingDone: _handleCalculatingDone),
        ValueListenableBuilder(
          valueListenable: resultsVn,
          builder: (resultsContext, results, _) => Expanded(
            child: Column(
              children: [
                if (results != null) ...[
                  const Divider(),
                  ValueListenableBuilder(
                    valueListenable: isLoadingVn,
                    builder: (isLoadingContext, isLoading, _) => Expanded(
                      child: Column(
                        children: [
                          if (isLoading == true)
                            const SizedBox(
                              width: 100,
                              height: 100,
                              child: CircularProgressIndicator(strokeWidth: 3),
                            ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: isLoading
                                ? null
                                : () => _onPress(isLoadingContext, results),
                            child: const Text("Send results to server"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ] else
                  const Spacer(),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  Future<void> _onPress(
    BuildContext context,
    List<PathfindResult>? results,
  ) async {
    try {
      if (results == null) return;
      isLoadingVn.value = true;
      final response = await RepositoryScope.of(context).checkTasks(results!);
      if (!context.mounted) return;
      _goNextPage(context, results);
    } catch (e) {
      //TODO: Handle error
      print("ERROR-$e");
    } finally {
      isLoadingVn.value = false;
    }
  }

  void _goNextPage(BuildContext context, List<PathfindResult>? results) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ResultListScreen(results: results!)),
    );
  }
}
