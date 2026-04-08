import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_mate/core/theme/app_colors.dart';
import 'package:study_mate/features/subject/presentation/widgets/subject_card.dart';

import '../bloc/subject_cubit.dart';
import '../bloc/subject_state.dart';
import '../widgets/add_subject_header.dart';

class AddSubjectScreen extends StatefulWidget {
  const AddSubjectScreen({super.key});

  @override
  State<AddSubjectScreen> createState() => _AddSubjectScreenState();
}

class _AddSubjectScreenState extends State<AddSubjectScreen> {
  final TextEditingController _subjectController = TextEditingController();

  final List<Color> _colors = [
    AppColors.blue,
    AppColors.purple,
    AppColors.green,
    AppColors.red,
    AppColors.orange,
    AppColors.yellow,
    AppColors.pink,
    AppColors.indigo,
  ];

  @override
  void dispose() {
    _subjectController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // BlocBuilder rebuilds whenever name or color changes in the cubit.
    return BlocBuilder<SubjectCubit, SubjectState>(
      builder: (context, state) {
        final selectedColor = state.color;
        final previewName = state.name;

        return Scaffold(
          backgroundColor: AppColors.lightBackground,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.sizeOf(context).height*.8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Header ─────────────────────────────────────────────
                      AddSubjectHeader(),

                      const SizedBox(height: 20),

                      // ── Name field ─────────────────────────────────────────
                      const Text("اسم المادة"),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _subjectController,
                        onChanged: context.read<SubjectCubit>().updateName,
                        decoration: InputDecoration(
                          hintText: "مثال: رياضيات",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // ── Color picker ───────────────────────────────────────
                      const Text("اختر اللون"),
                      const SizedBox(height: 12),
                      Center(
                        child: Wrap(
                          spacing: 14,
                          runSpacing: 12,
                          children: _colors.map((color) {
                            final isSelected = selectedColor.toARGB32() == color.toARGB32();
                            return GestureDetector(
                              onTap: () =>
                                  context.read<SubjectCubit>().selectColor(color),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(16),
                                  border: isSelected
                                      ? Border.all(color: Colors.black, width: 3)
                                      : Border.all(
                                          color: Colors.transparent, width: 3),
                                  boxShadow: isSelected
                                      ? [
                                          BoxShadow(
                                            color: color.withValues(alpha: 0.5),
                                            blurRadius: 8,
                                            spreadRadius: 1,
                                          )
                                        ]
                                      : null,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                      const SizedBox(height: 20),


                      // ── Live preview ───────────────────────────────────────
                      const Text("معاينة"),
                      const SizedBox(height: 12),
                      SubjectCard(
                        name:
                            previewName.isEmpty ? "اسم المادة" : previewName,
                        color: selectedColor,
                        icon: Icons.menu_book,
                        onDelete: () {},
                      ),

                      const Spacer(),

                      // ── Add button ─────────────────────────────────────────
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            backgroundColor: Colors.green,
                          ),
                          onPressed: () async {
                            await context.read<SubjectCubit>().addSubject();
                            if (context.mounted) {
                              _subjectController.clear();
                              context.read<SubjectCubit>().resetForm();
                              Navigator.pop(context);
                            }
                          },
                          child: const Text(
                            "إضافة المادة",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
