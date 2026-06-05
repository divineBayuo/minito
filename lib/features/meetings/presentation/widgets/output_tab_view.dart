// shows one tab per meetingoutput, rendering its markdown content
// an emty state is shown when no outputs have been generated yet
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:minito/core/utils/file_utils.dart';
import 'package:minito/features/meetings/domain/models/meeting_output.dart';

class OutputTabView extends StatelessWidget {
  const OutputTabView({
    super.key,
    required this.outputs,
    required this.meetingTitle,
  });

  final List<MeetingOutput> outputs;
  final String meetingTitle;

  @override
  Widget build(BuildContext context) {
    if (outputs.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Text('No documents generated yet.\nCheck back shortly.'),
        ),
      );
    }

    return DefaultTabController(
      length: outputs.length,
      child: Column(
        children: [
          TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            tabs: outputs
                .map((o) => Tab(text: '${o.type.icon} ${o.type.label}'))
                .toList(),
          ),
          Expanded(
            child: TabBarView(
              children: outputs
                  .map(
                    (o) => _OutputPage(output: o, meetingTitle: meetingTitle),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _OutputPage extends StatelessWidget {
  const _OutputPage({required this.output, required this.meetingTitle});

  final MeetingOutput output;
  final String meetingTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      // share/export toolbar
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () => FileUtils.shareAsMarkdown(
                  content: output.markdownContent,
                  fileName: '${meetingTitle}_${output.type.name}',
                ),
                label: const Text('Share'),
                icon: const Icon(Icons.share_outlined, size: 18),
              ),
              TextButton.icon(
                onPressed: () {
                  // copy full markdown text to clipboard
                  // requires clipboard package or flutter's built-in
                },
                label: const Text('Copy'),
                icon: Icon(Icons.copy_outlined, size: 18),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        // Markdown renderer
        Expanded(
          child: Markdown(
            data: output.markdownContent,
            padding: const EdgeInsets.all(20),
            styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)),
            selectable: true,
          ),
        ),
      ],
    );
  }
}
