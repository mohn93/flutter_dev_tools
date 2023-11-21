import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dev_tools/shared/alerts.dart';
import 'package:flutter_dev_tools/tools/http_logger/entity/http_data.dart';
import 'package:flutter_dev_tools/tools/http_logger/utils/pretty_map.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class HttpLoggerListTile extends StatelessWidget {
  const HttpLoggerListTile({super.key, required this.data});

  final HTTPLoggerData data;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final statusCode = data.response?.statusCode;
    final statusColor = statusCode != null
        ? statusCode >= 400
            ? Colors.red
            : Colors.green
        : Colors.grey;
    final statusMessage = data.response?.statusMessage;
    final dateString = DateFormat('dd MMM yyyy - HH:mm:ss').format(
      data.response?.createdAt ?? data.request.createdAt,
    );
    final responseTime = data.response?.createdAt
        .difference(data.request.createdAt)
        .inMilliseconds;
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ExpansionTile(
          title: Text(
            data.request.uri.toString(),
            style: textTheme.labelSmall,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  responseTime != null ? '$responseTime ms' : 'Pending',
                  style: textTheme.labelSmall,
                ),
                const Gap(4),
                Text(
                  dateString,
                  style: textTheme.bodySmall,
                ),
              ],
            ),
          ),
          leading: InkWell(
            onTap: () => AppDevAlerts.showInfoDialog(
              context,
              widget: Text('Status Message: $statusMessage'),
            ),
            child: Column(
              children: [
                Text(data.request.method),
                const Gap(4),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: SizedBox(
                    width: 48,
                    child: Column(
                      children: [
                        statusCode != null
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    statusCode.toString(),
                                    style: TextStyle(
                                      color: colorScheme.surface,
                                    ),
                                  ),
                                  const Gap(4),
                                  Icon(
                                    Icons.info_outline,
                                    color: colorScheme.outline,
                                    size: 12,
                                  ),
                                ],
                              )
                            : Icon(
                                Icons.downloading_rounded,
                                color: colorScheme.surface,
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          children: [
            ExpansionTile(
              title: Text(
                'Request',
                style: textTheme.labelMedium,
              ),
              childrenPadding:
                  const EdgeInsetsDirectional.only(start: 16, end: 0),
              children: [
                if (data.request.headers.isNotEmpty)
                  ListTile(
                    title: Text(
                      'Headers',
                      style: textTheme.labelSmall,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () =>
                              performCopy(context, '${data.request.headers}'),
                          icon: const Icon(
                            Icons.copy,
                            size: 16,
                          ),
                        ),
                        IconButton(
                          onPressed: () => showHeadersTableBottomSheet(
                              context, 'Request Headers', data.request.headers),
                          icon: const Icon(
                            Icons.remove_red_eye,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (data.request.data.isNotEmpty)
                  ListTile(
                    title: Text(
                      'Body: ${data.response!.headers['content-type']} , ${data.response!.data.length} bytes',
                      style: textTheme.labelSmall,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () =>
                              performCopy(context, '${data.request.data}'),
                          icon: const Icon(
                            Icons.copy,
                            size: 16,
                          ),
                        ),
                        IconButton(
                          onPressed: () => AppDevAlerts.showBottomSheet(context,
                              title: 'Request Body',
                              widget: Text(prettyMap(data.request.data))),
                          icon: const Icon(
                            Icons.remove_red_eye,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            if (data.response != null) ...[
              ExpansionTile(
                title: Text(
                  'Response',
                  style: textTheme.labelMedium,
                ),
                childrenPadding:
                    const EdgeInsetsDirectional.only(start: 16, end: 0),
                children: [
                  ListTile(
                    title: Text(
                      'Headers (${data.response!.headers.length})',
                      style: textTheme.labelSmall,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () =>
                              performCopy(context, '${data.request.headers}'),
                          icon: const Icon(
                            Icons.copy,
                            size: 16,
                          ),
                        ),
                        IconButton(
                          onPressed: () => showHeadersTableBottomSheet(
                            context,
                            'Response Headers',
                            data.response!.headers,
                          ),
                          icon: const Icon(
                            Icons.remove_red_eye,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Body: ${data.response!.headers['content-type']} , ${data.response!.data.length} bytes',
                      style: textTheme.labelSmall,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () =>
                              performCopy(context, '${data.response!.data}'),
                          icon: const Icon(
                            Icons.copy,
                            size: 16,
                          ),
                        ),
                        IconButton(
                          onPressed: () => AppDevAlerts.showBottomSheet(context,
                              title: 'Response Body',
                              widget: Text(data.response!.prettyData)),
                          icon: const Icon(
                            Icons.remove_red_eye,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (data.response!.error != null)
                    ListTile(
                      title: Text(
                        'Error',
                        style: textTheme.labelSmall,
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () =>
                                performCopy(context, '${data.response!.error}'),
                            icon: const Icon(
                              Icons.copy,
                              size: 16,
                            ),
                          ),
                          IconButton(
                            onPressed: () => AppDevAlerts.showBottomSheet(
                                context,
                                title: 'Response Error',
                                widget: Text(data.response!.error!)),
                            icon: const Icon(
                              Icons.remove_red_eye,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  void showHeadersTableBottomSheet(
    BuildContext context,
    String title,
    Map<String, dynamic> headers,
  ) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    AppDevAlerts.showBottomSheet(
      context,
      title: title,
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Table(
            border: TableBorder.all(
              color: colorScheme.onSurface.withOpacity(0.15),
              borderRadius: BorderRadius.circular(4),
            ),
            children: [
              ...headers.entries.map(
                (entry) => TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text(
                        entry.key,
                        style: textTheme.bodySmall,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 6),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${entry.value}',
                              style: textTheme.bodySmall,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              performCopy(context, entry.value.toString());
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.copy,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void performCopy(BuildContext context, String text) {
    Clipboard.setData(
      ClipboardData(
        text: text,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Copied to clipboard'),
      ),
    );
  }
}
