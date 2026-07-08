import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/gorev_model.dart';
import 'package:intl/intl.dart';
import '../../../shared/widgets/status_badge.dart';

class GorevKanbanScreen extends StatelessWidget {
  const GorevKanbanScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          'Kanban Görünüm',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _KanbanColumn(
              title: 'Yapılacak',
              status: GorevStatus.todo,
              color: AppColors.textSecondary,
              tasks: mockGorevler.where((t) => t.status == GorevStatus.todo).toList(),
            ),
            const SizedBox(width: 24),
            _KanbanColumn(
              title: 'Devam Ediyor',
              status: GorevStatus.inProgress,
              color: AppColors.warning,
              tasks: mockGorevler.where((t) => t.status == GorevStatus.inProgress).toList(),
            ),
            const SizedBox(width: 24),
            _KanbanColumn(
              title: 'İncelemede',
              status: GorevStatus.review,
              color: AppColors.primaryGreen,
              tasks: mockGorevler.where((t) => t.status == GorevStatus.review).toList(),
            ),
            const SizedBox(width: 24),
            _KanbanColumn(
              title: 'Tamamlandı',
              status: GorevStatus.done,
              color: AppColors.success,
              tasks: mockGorevler.where((t) => t.status == GorevStatus.done).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _KanbanColumn extends StatelessWidget {
  final String title;
  final GorevStatus status;
  final Color color;
  final List<GorevModel> tasks;

  const _KanbanColumn({
    required this.title,
    required this.status,
    required this.color,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.black900),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.borderLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${tasks.length}',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...tasks.map((t) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _KanbanCard(task: t),
              )),
          if (tasks.isEmpty)
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.bgCard,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.borderLight, style: BorderStyle.solid),
              ),
              child: Center(
                child: Text('Görev Yok', style: TextStyle(color: AppColors.textHint, fontWeight: FontWeight.w600)),
              ),
            )
        ],
      ),
    );
  }
}

class _KanbanCard extends StatelessWidget {
  final GorevModel task;
  const _KanbanCard({required this.task});

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
            color: AppColors.black900.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: task.priority.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  task.priority.label,
                  style: TextStyle(
                    color: task.priority.color,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Icon(Icons.more_horiz_rounded, size: 20, color: AppColors.textSecondary),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            task.title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            task.description,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (task.subtasksCount > 0) ...[
                    const Icon(Icons.checklist_rounded, size: 14, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Text('${task.subtasksCompleted}/${task.subtasksCount}', style: const TextStyle(fontSize: 11, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                    const SizedBox(width: 8),
                  ],
                  if (task.commentsCount > 0) ...[
                    const Icon(Icons.chat_bubble_outline_rounded, size: 14, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Text('${task.commentsCount}', style: const TextStyle(fontSize: 11, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                  ],
                ],
              ),
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
    );
  }
}
