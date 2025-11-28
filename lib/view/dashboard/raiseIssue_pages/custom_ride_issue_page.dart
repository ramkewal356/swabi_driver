// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_driver/data/response/status.dart';
import 'package:flutter_driver/widgets/custom_btn.dart';
import 'package:flutter_driver/widgets/custom_page_layout.dart';
import 'package:flutter_driver/widgets/custom_text_form_field.dart';
import 'package:flutter_driver/common/styles/app_colors.dart';
import 'package:flutter_driver/common/styles/text_styles.dart';
import 'package:flutter_driver/core/utils/utils.dart';
import 'package:flutter_driver/view_model/raise_issue_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CustomRideissuePage extends StatefulWidget {
  final String bookingId;
  final String bookingType;
  final String vendorId;
  const CustomRideissuePage(
      {super.key,
      required this.bookingId,
      required this.bookingType,
      required this.vendorId});

  @override
  State<CustomRideissuePage> createState() => _CustomRideissuePageState();
}

class _CustomRideissuePageState extends State<CustomRideissuePage> {
  String? _selectedIssue;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  final List<String> _issueOptions = [
    'Customer Not Present at Pickup Location',
    'Incorrect Rental Details',
    'Customer Refusal to Follow Rental Terms',
    'Customer Uncooperative or Unpleasant Behavior',
    'My reason is not listed',
  ];
  @override
  Widget build(BuildContext context) {
    var status =
        context.watch<RaiseIssueViewModel>().raiseRequestResonse.status;
    return CustomPageLayout(
      appBarTitle: 'Raise Issue',
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: _issueOptions.map((issue) {
                  return RadioListTile<String>(
                    contentPadding: EdgeInsets.zero,
                    activeColor: btnColor,
                    dense: true,
                    visualDensity:
                        const VisualDensity(horizontal: -2, vertical: -2),
                    title: Text(
                      issue,
                      style: textTextStyle,
                    ),
                    value: issue,
                    groupValue: _selectedIssue,
                    onChanged: (value) {
                      setState(() {
                        _selectedIssue = value;
                      });
                    },
                  );
                }).toList(),
              ),
              if (_selectedIssue == 'My reason is not listed')
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Customtextformfield(
                          controller: _descriptionController,
                          hintText: 'Description For Issue',
                          maxLines: 4,
                          minLines: 4,
                          textLength: 120,
                          validator: (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return 'Please enter description';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              // Spacer(),
              CustomButtonSmall(
                  height: 45,
                  width: double.infinity,
                  loading: status == Status.loading,
                  btnHeading: 'Submit',
                  onTap: () {
                    if (_selectedIssue != null) {
                      // Handle submit action
                      debugPrint('Issue Selected: $_selectedIssue');
                      if (_selectedIssue == 'My reason is not listed') {
                        debugPrint(
                            'Description: ${_descriptionController.text}');
                        if (_formKey.currentState!.validate()) {
                          context
                              .read<RaiseIssueViewModel>()
                              .requestRaiseIssue(
                                  context: context,
                                  bookingId: widget.bookingId,
                                  bookingType: widget.bookingType,
                                  issueDescription: _selectedIssue ==
                                          'My reason is not listed'
                                      ? _descriptionController.text
                                      : _selectedIssue ?? '',
                                  vendorId: widget.vendorId)
                              .then((onValue) {
                            if (onValue?.status?.httpCode == '200') {
                              Utils.toastSuccessMessage(
                                'Raise Issue Request Successfully',
                              );
                              context.pop();
                            }
                          });
                        }
                      } else {
                        context
                            .read<RaiseIssueViewModel>()
                            .requestRaiseIssue(
                                context: context,
                                bookingId: widget.bookingId,
                                bookingType: widget.bookingType,
                                issueDescription:
                                    _selectedIssue == 'My reason is not listed'
                                        ? _descriptionController.text
                                        : _selectedIssue ?? '',
                                vendorId: widget.vendorId)
                            .then((onValue) {
                          if (onValue?.status?.httpCode == '200') {
                            Utils.toastSuccessMessage(
                              'Raise Issue Request Successfully',
                            );
                            context.pop();
                          }
                        });
                      }
                    } else {
                      Utils.toastMessage('Please select an issue.');
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
