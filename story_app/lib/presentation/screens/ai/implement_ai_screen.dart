import 'package:flutter/material.dart';
import 'package:story_app/presentation/widgets/button_global_widget.dart';
import 'package:story_app/presentation/widgets/show_dialog_widget.dart';
import 'package:story_app/presentation/widgets/text_field_input.dart';
import 'package:story_app/utils/constant/validation.dart';

class ImplementAIScreen extends StatefulWidget {
  const ImplementAIScreen({super.key});

  @override
  State<ImplementAIScreen> createState() => _ImplementAIScreenState();
}

class _ImplementAIScreenState extends State<ImplementAIScreen> {
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _themeController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();

  final FocusNode _cityFocusNode = FocusNode();
  final FocusNode _themeFocusNode = FocusNode();
  final FocusNode _budgetFocusNode = FocusNode();

  String? _cityErrorText;
  String? _themeErrorText;
  String? _budgetErrorText;

  @override
  void dispose() {
    super.dispose();
    _cityController.dispose();
    _themeController.dispose();
    _budgetController.dispose();
    _cityFocusNode.dispose();
    _themeFocusNode.dispose();
    _budgetFocusNode.dispose();
  }

  void _validateInputs() {
    setState(() {
      _cityErrorText =
          Validation.validateNotEmpty(_cityController.text, "City Name");
      _themeErrorText =
          Validation.validateNotEmpty(_themeController.text, "Theme");
      _budgetErrorText =
          Validation.validateNotEmpty(_budgetController.text, "Budget");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI to Recommend top 5 places"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFieldInput(
                textEditingController: _cityController,
                isPass: false,
                hintText: "Enter City",
                textInputType: TextInputType.streetAddress,
                focusNode: _cityFocusNode,
                errorText: _cityErrorText,
                onChange: (value) {
                  setState(() {
                    _cityErrorText =
                        Validation.validateNotEmpty(value, "City Name");
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFieldInput(
                textEditingController: _themeController,
                isPass: false,
                hintText: "Enter Theme",
                textInputType: TextInputType.name,
                focusNode: _themeFocusNode,
                errorText: _themeErrorText,
                onChange: (value) {
                  setState(() {
                    _themeErrorText =
                        Validation.validateNotEmpty(value, "Theme");
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFieldInput(
                textEditingController: _budgetController,
                isPass: false,
                hintText: "Enter Budget",
                textInputType: TextInputType.number,
                focusNode: _budgetFocusNode,
                errorText: _budgetErrorText,
                onChange: (value) {
                  setState(() {
                    _budgetErrorText =
                        Validation.validateNotEmpty(value, "Budget");
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ButtonGlobalWidget(
                title: const Text("Generate"),
                onTap: () {
                  final city = _cityController.text;
                  final theme = _themeController.text;
                  final budget = _budgetController.text;

                  _cityErrorText =
                      Validation.validateNotEmpty(city, "City Name");
                  _themeErrorText = Validation.validateNotEmpty(theme, "Theme");
                  _budgetErrorText =
                      Validation.validateNotEmpty(budget, "Budget");
                  if (_cityErrorText != null) {
                    ShowDialogWidget.showErrorDialog(
                      context: context,
                      title: 'Validation Error',
                      message: _cityErrorText!,
                    );
                  } else if (_themeErrorText != null) {
                    ShowDialogWidget.showErrorDialog(
                      context: context,
                      title: 'Validation Error',
                      message: _themeErrorText!,
                    );
                  } else if (_budgetErrorText != null) {
                    ShowDialogWidget.showErrorDialog(
                      context: context,
                      title: 'Validation Error',
                      message: _budgetErrorText!,
                    );
                  } else {
                    
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
