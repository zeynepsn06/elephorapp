import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/gorev_model.dart';
import 'package:intl/intl.dart';
import '../../../shared/widgets/status_badge.dart';

class GorevListScreen extends StatelessWidget {
  const GorevListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = mockGorevler.where((t) => t.status != GorevStatus.done).toList();

    return Scaffold(
      backgroundColor: AppColors.bgPage,
      appBar: AppBar(
        backgroundColor: AppColors.bgPage,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Liste Görünüm',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_rounded, color: AppColors.primaryGreen),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(24),
        itemCount: tasks.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final task = tasks[index];
          return _ListCard(task: task);
        },
      ),
    );
  }
}

class _ListCard extends StatelessWidget {
  final GorevModel task;
  const _ListCard({required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black900.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: task.priority.color, width: 2),
            ),
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: task.priority.color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        task.title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    StatusBadge(
                      label: task.status.label,
                      type: task.status == GorevStatus.todo
                          ? BadgeType.neutral
                          : task.status == GorevStatus.inProgress
                              ? BadgeType.warning
                              : BadgeType.success,
                      small: true,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  task.description,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        if (task.subtasksCount > 0) ...[
                          const Icon(Icons.checklist_rounded, size: 14, color: AppColors.textSecondary),
                          const SizedBox(width: 4),
                          Text('${task.subtasksCompleted}/${task.subtasksCount}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                          const SizedBox(width: 12),
                        ],
                        if (task.commentsCount > 0) ...[
                          const Icon(Icons.chat_bubble_outline_rounded, size: 14, color: AppColors.textSecondary),
                          const SizedBox(width: 4),
                          Text('${task.commentsCount}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                          const SizedBox(width: 12),
                        ],
                        if (task.attachmentsCount > 0) ...[
                          const Icon(Icons.attach_file_rounded, size: 14, color: AppColors.textSecondary),
                          const SizedBox(width: 4),
                          Text('${task.attachmentsCount}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                        ],
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today_rounded, size: 14, color: AppColors.textSecondary),
                        const SizedBox(width: 4),
                        Text(
                          DateFormat('d MMM', 'tr_TR').format(task.dueDate),
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: AppColors.primaryGreen.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              task.assigneeInitials,
                              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.primaryGreen),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
