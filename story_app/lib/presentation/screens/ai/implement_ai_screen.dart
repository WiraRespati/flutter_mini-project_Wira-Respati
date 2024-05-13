import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
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
  List<String> recommendations = [];
  bool _isLoading = false;

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

  void _submitForm() async {
    final input = {
      'city': _cityController.text,
      'theme': _themeController.text,
      'budget': _budgetController.text,
    };

    final question =
        "Berikan 5 rekomendasi nama tempat di ${input['city']} dengan tema ${input['theme']} dan budget ${input['budget']} !";
    setState(() {
      _isLoading = true;
    });
    await for (var event in Gemini.instance.streamGenerateContent(question)) {
      final responseParts = event.content?.parts;
      if (responseParts != null) {
        String response = '';
        for (var part in responseParts) {
          response += part.text!;
        }
        setState(() {
          recommendations.add(response);
          _isLoading = false;
        });
        _cityController.clear();
        _themeController.clear();
        _budgetController.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Recommend With AI",
          style: TextStyle(fontFamily: 'BriemHand'),
        ),
        actions: [
          IconButton(
              onPressed: () {
                _cityController.clear();
                _themeController.clear();
                _budgetController.clear();
                setState(() {
                  recommendations = [];
                });
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.asset(
                    'assets/gemini.png',
                    fit: BoxFit.cover,
                  )),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Fill the form to get recommendations cool place from AI',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
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
                  onTap: _isLoading
                      ? null
                      : () {
                          final city = _cityController.text;
                          final theme = _themeController.text;
                          final budget = _budgetController.text;

                          _cityErrorText =
                              Validation.validateNotEmpty(city, "City Name");
                          _themeErrorText =
                              Validation.validateNotEmpty(theme, "Theme");
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
                            _submitForm();
                          }
                        },
                  title: _isLoading
                      ? const SizedBox(
                          height: 20.0,
                          width: 20.0,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.0,
                          ),
                        )
                      : const Text("Generate"),
                ),
              ),
              if (recommendations.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Recommendations:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: recommendations.map((recommendation) {
                          return Text(
                            '${recommendations.indexOf(recommendation) + 1}. $recommendation',
                            style: const TextStyle(fontSize: 16),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
