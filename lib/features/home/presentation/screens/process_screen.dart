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
    body: const Padding(
      padding: EdgeInsets.only(bottom: 32),
      child: _ProcessScreenBody(),
    ),
  );
}

class _ProcessScreenBody extends StatefulWidget {
  const _ProcessScreenBody();

  @override
  State<StatefulWidget> createState() => _ProcessScreenBodyState();
}

class _ProcessScreenBodyState extends State<_ProcessScreenBody> {
  final _resultsVn = ValueNotifier<List<PathfindResult>?>(null);
  final _isLoadingVn = ValueNotifier<bool>(false);
  final _errorVn = ValueNotifier<String?>(null);

  @override
  void dispose() {
    _resultsVn.dispose();
    _isLoadingVn.dispose();
    _errorVn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: .max,
    mainAxisAlignment: .end,
    crossAxisAlignment: .stretch,
    children: [
      const Spacer(),
      CalculatingData(
        onCalculatingDone: (list) => _resultsVn.value = list,
      ),
      Expanded(
        child: ValueListenableBuilder(
          valueListenable: _resultsVn,
          builder: (resultsContext, results, _) {
            if (results == null) return const SizedBox.shrink();
            return Column(
              children: [
                const Divider(),
                // Error block
                ValueListenableBuilder(
                  valueListenable: _errorVn,
                  builder: (errorContext, error, _) =>
                      error != null ? Text(error) : const Text(""),
                ),
                // Indicator + Button Block
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: _isLoadingVn,
                    builder: (isLoadingContext, isLoading, _) => Column(
                      children: [
                        if (isLoading == true) const _ProgressIndicator(),
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
              ],
            );
          },
        ),
      ),
    ],
  );

  Future<void> _onPress(
    BuildContext context,
    List<PathfindResult>? results,
  ) async {
    try {
      _errorVn.value = null;
      if (results == null) return;

      _isLoadingVn.value = true;

      final response = await RepositoryScope.of(context).checkTasks(results);
      if (response.any((r) => !r.correct)) {
        _errorVn.value = "The results have incorrect answer";
        return;
      }

      if (!context.mounted) return;
      _goNextPage(context, results);
    } catch (e) {
      if (!mounted) return;
      _errorVn.value = "Error during result sending: $e";
    } finally {
      if (mounted) {
        _isLoadingVn.value = false;
      }
    }
  }

  void _goNextPage(BuildContext context, List<PathfindResult>? results) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ResultListScreen(results: results!)),
    );
  }
}

class _ProgressIndicator extends StatelessWidget {
  const _ProgressIndicator();
  @override
  Widget build(BuildContext context) => const SizedBox(
    width: 100,
    height: 100,
    child: CircularProgressIndicator(strokeWidth: 3),
  );
}
