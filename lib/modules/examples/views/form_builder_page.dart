// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

// Project imports:
import 'package:pigeon/common/extensions/single.dart';
import 'package:pigeon/common/widgets/widgets.dart';
import 'package:pigeon/theme/colors.dart';

class FormBuilderPage extends StatefulWidget {
  const FormBuilderPage({super.key});

  @override
  State<FormBuilderPage> createState() => _FormBuilderPageState();
}

class _FormBuilderPageState extends State<FormBuilderPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  final accountFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Builder Example')),
      body: Column(
        children: [
          FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                BaseFormItem(
                  title: '账号',
                  showTip: false,
                  padding: EdgeInsets.zero,
                  child: FormBuilderField<String>(
                    focusNode: accountFocusNode,
                    builder: (FormFieldState<String> field) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            initialValue: field.value,
                            focusNode: accountFocusNode,
                            cursorColor: primaryColor,
                            cursorErrorColor: errorTextColor,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            autocorrect: false,
                            style: const TextStyle(
                              color: primaryTextColor,
                            ),
                            onChanged: (value) {
                              // field
                              //   ..didChange(value)
                              //   ..validate();
                            },
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.fromLTRB(
                                10,
                                10,
                                5,
                                10,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: const BorderSide(
                                  color: borderColor,
                                ),
                                gapPadding: 0,
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: const BorderSide(
                                  color: borderColor,
                                ),
                                gapPadding: 0,
                              ),
                              hintText: '请输入账号',
                              helperText: '只能包含英文, 数字或下划线, 且只能以字母开头, 至少8个字符',
                              helperStyle: const TextStyle(
                                color: secondaryTextColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                              errorText: field.errorText,
                              errorStyle: const TextStyle(
                                fontSize: 12,
                                color: errorTextColor,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: const BorderSide(
                                  color: primaryColor,
                                ),
                                gapPadding: 0,
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: const BorderSide(
                                  color: errorTextColor,
                                ),
                                gapPadding: 0,
                              ),
                              // fillColor: epPrimaryGrayColor,
                              // filled: true,
                            ),
                          ),
                        ],
                      );
                    },
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: '请输入账号',
                      ),
                      FormBuilderValidators.match(
                        RegExp('[a-zA-Z][a-zA-Z0-9_]{7,}', multiLine: true),
                        errorText: '账号只能包含英文,数字或下划线, 且只能以字母开头, 至少8个字符',
                      ),
                    ]),
                    name: 'account',
                  ).nestedPadding(
                    padding: const EdgeInsets.only(top: 8),
                  ),
                ),
                ElevatedButton(onPressed: _submit, child: const Text('Submit')),
                ElevatedButton(onPressed: _clear, child: const Text('Clear')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {}
  }

  void _clear() {
    _formKey.currentState!.reset();
  }
}
