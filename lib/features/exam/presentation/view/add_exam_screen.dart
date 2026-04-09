import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:study_mate/core/theme/app_colors.dart';
import 'package:study_mate/core/widgets/add_thing_header.dart';
import 'package:study_mate/features/subject/presentation/bloc/subject_cubit.dart';
import 'package:study_mate/features/subject/presentation/bloc/subject_state.dart';

import '../bloc/exam_cubit.dart';
import '../bloc/exam_state.dart';

class AddExamScreen extends StatelessWidget {
  const AddExamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamCubit, ExamState>(
      builder: (context, examState) {
        final examCubit = context.read<ExamCubit>();

        // ── Read subjects from SubjectCubit ──────────────────────────────────
        // SubjectCubit is already provided higher in the tree (same place that
        // powers AddSubjectScreen). We just read its current state here.
        final subjectState = context.watch<SubjectCubit>().state;
        final subjects = subjectState is SubjectLoaded ? subjectState.subjects : [];

        return Scaffold(
          backgroundColor: AppColors.lightBackground,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// ── Header ─────────────────────────────
                  const AddThingHeader(label: "اضافه امتحان"),

                  const SizedBox(height: 20),

                  /// ── Subject Dropdown ───────────────────
                  const Text("المادة"),
                  const SizedBox(height: 8),

                  subjects.isEmpty
                      ? Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.info_outline,
                            color: Colors.orange, size: 18),
                        SizedBox(width: 8),
                        Text(
                          "لا توجد مواد — أضف مادة أولاً",
                          style: TextStyle(color: Colors.orange),
                        ),
                      ],
                    ),
                  )
                      : DropdownButtonFormField<String>(
                    initialValue: examState.selectedSubjectId,
                    items: subjects
                        .map<DropdownMenuItem<String>>(
                          (s) => DropdownMenuItem(
                        value: s.id,
                        child: Text(s.name),
                      ),
                    )
                        .toList(),
                    onChanged: (value) {
                      final name = subjects.firstWhere((s) => s.id == value).name;
                      examCubit.selectTheSubject(value,name);
                    },
                    decoration: InputDecoration(
                      hintText: "اختر المادة",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// ── Date Picker ────────────────────────
                  const Text("تاريخ الامتحان"),
                  const SizedBox(height: 8),

                  GestureDetector(
                    onTap: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        examCubit.selectTheDate(pickedDate);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        examState.selectedDate == null
                            ? "dd/mm/yyyy"
                            : DateFormat('dd/MM/yyyy')
                            .format(examState.selectedDate!),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// ── Time Picker ────────────────────────
                  const Text("الوقت"),
                  const SizedBox(height: 8),

                  GestureDetector(
                    onTap: () async {
                      final pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedTime != null) {
                        examCubit.selectTime(pickedTime);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        examState.selectedTime == null
                            ? "اختر الوقت"
                            : examState.selectedTime!.format(context),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// ── Info Banner ────────────────────────
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.info, color: Colors.blue),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "سيتم حساب العد التنازلي تلقائيا بناء علي التاريخ المحدد",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  /// ── Submit Button ──────────────────────
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () async {
                        if (!examCubit.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("من فضلك اكمل كل البيانات"),
                            ),
                          );
                          return;
                        }

                        await examCubit.addExam();

                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        "إضافة الامتحان",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}