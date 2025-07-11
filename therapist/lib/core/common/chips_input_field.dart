import 'dart:async';

import 'package:flutter/material.dart';

class OfferedTherapiesChoiceChipInput extends StatefulWidget {
  const OfferedTherapiesChoiceChipInput({
    super.key,
    this.initialSelected = const <String>[],
    required this.therapies,
    required this.onSelectedTherapiesChanged,
  });

  final List<String> therapies;
  final List<String> initialSelected;
  final ValueChanged<List<String>> onSelectedTherapiesChanged;

  @override
  State<OfferedTherapiesChoiceChipInput> createState() =>
      _OfferedTherapiesChoiceChipInputState();
}

class _OfferedTherapiesChoiceChipInputState
    extends State<OfferedTherapiesChoiceChipInput> {
  final FocusNode _chipFocusNode = FocusNode();
  late List<String> _selectedTherapies;
  List<String> _suggestions = <String>[];

  @override
  void initState() {
    super.initState();
    _selectedTherapies = List<String>.from(widget.initialSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '  Offered Therapies',
          style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              height: 1.25,
              fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 4),
        ChipsInput(
          values: _selectedTherapies,
          strutStyle: const StrutStyle(fontSize: 16),
          onChanged: _onChanged,
          chipBuilder: _chipBuilder,
          onSubmitted: _onSubmitted,
          onTextChanged: _onSearchChanged,
        ),
        _suggestions.isNotEmpty
            ? SizedBox(
                height: 300,
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 6.0,
                    children: _suggestions.map((String therapy) {
                      return TherapySuggestion(therapy,
                          onTap: _selectSuggestion);
                    }).toList(),
                  ),
                ),
              )
            : const SizedBox.shrink()
      ],
    );
  }

  void _selectSuggestion(String therapy) {
    setState(() {
      _selectedTherapies.add(therapy);
      _suggestions = <String>[];
    });
    widget.onSelectedTherapiesChanged(_selectedTherapies);
  }

  FutureOr<List<String>> _suggestionCallback(String text) {
    if (text.isNotEmpty) {
      return widget.therapies.where((String therapy) {
        return therapy.toLowerCase().contains(text.toLowerCase());
      }).toList();
    }
    return const <String>[];
  }

  Future<void> _onSearchChanged(String value) async {
    final List<String> results = await _suggestionCallback(value);
    setState(() {
      _suggestions = results
          .where((String therapy) => !_selectedTherapies.contains(therapy))
          .toList();
    });
  }

  void _onSubmitted(String text) {
    if (text.trim().isNotEmpty) {
      setState(() {
        _selectedTherapies = <String>[..._selectedTherapies, text.trim()];
      });
      widget.onSelectedTherapiesChanged(_selectedTherapies);
    } else {
      _chipFocusNode.unfocus();
      setState(() {
        _selectedTherapies = <String>[];
      });
      widget.onSelectedTherapiesChanged(_selectedTherapies);
    }
  }

  Widget _chipBuilder(BuildContext context, String therapy) {
    return TherapyInputChip(
        therapy: therapy, onDeleted: _onChipDeleted, onSelected: _onChipTapped);
  }

  void _onChipDeleted(String therapy) {
    setState(() {
      _selectedTherapies.remove(therapy);
      _suggestions = <String>[];
    });
    widget.onSelectedTherapiesChanged(_selectedTherapies);
  }

  void _onChipTapped(String therapy) {}

  void _onChanged(List<String> data) {
    setState(() {
      _selectedTherapies = data;
    });
    widget.onSelectedTherapiesChanged(_selectedTherapies);
  }
}

class ChipsInput<T> extends StatefulWidget {
  const ChipsInput({
    super.key,
    required this.values,
    this.style,
    this.strutStyle,
    required this.onChanged,
    this.onChipTapped,
    this.onSubmitted,
    this.onTextChanged,
    required this.chipBuilder,
  });

  final List<T> values;
  final TextStyle? style;
  final StrutStyle? strutStyle;

  final ValueChanged<List<T>> onChanged;
  final ValueChanged<T>? onChipTapped;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onTextChanged;

  final Widget Function(BuildContext context, T data) chipBuilder;

  @override
  State<ChipsInput<T>> createState() => _ChipsInputState<T>();
}

class _ChipsInputState<T> extends State<ChipsInput<T>> {
  late final ChipsInputEditingController<T> controller;

  String _previousText = '';
  TextSelection? _previousSelection;

  @override
  void initState() {
    super.initState();

    controller = ChipsInputEditingController<T>(
        <T>[...widget.values], widget.chipBuilder);
    controller.addListener(_textListener);
  }

  @override
  void dispose() {
    controller.removeListener(_textListener);
    controller.dispose();

    super.dispose();
  }

  void _textListener() {
    final String currentText = controller.text;

    if (_previousSelection != null) {
      final int currentNumber = countReplacements(currentText);
      final int previousNumber = countReplacements(_previousText);

      final int cursorEnd = _previousSelection!.extentOffset;
      final int cursorStart = _previousSelection!.baseOffset;

      final List<T> values = <T>[...widget.values];

      if (currentNumber < previousNumber && currentNumber != values.length) {
        if (cursorStart == cursorEnd) {
          values.removeRange(cursorStart - 1, cursorEnd);
        } else {
          if (cursorStart > cursorEnd) {
            values.removeRange(cursorEnd, cursorStart);
          } else {
            values.removeRange(cursorStart, cursorEnd);
          }
        }
        widget.onChanged(values);
      }
    }

    _previousText = currentText;
    _previousSelection = controller.selection;
  }

  static int countReplacements(String text) {
    return text.codeUnits
        .where(
            (int u) => u == ChipsInputEditingController.kObjectReplacementChar)
        .length;
  }

  @override
  Widget build(BuildContext context) {
    controller.updateValues(<T>[...widget.values]);

    return TextField(
      minLines: 1,
      maxLines: 5,
      textInputAction: TextInputAction.done,
      textAlignVertical: TextAlignVertical.center,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        hintText: 'Type for suggestions',
        fillColor: Colors.blue,
        hintStyle: TextStyle(
          color: Colors.grey.shade600,
          fontSize: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        isCollapsed: false,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade600)),
        errorStyle: const TextStyle(color: Colors.red),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
      style: widget.style,
      strutStyle: widget.strutStyle,
      controller: controller,
      onChanged: (String value) =>
          widget.onTextChanged?.call(controller.textWithoutReplacements),
      onSubmitted: (String value) =>
          widget.onSubmitted?.call(controller.textWithoutReplacements),
    );
  }
}

class ChipsInputEditingController<T> extends TextEditingController {
  ChipsInputEditingController(this.values, this.chipBuilder)
      : super(
            text: String.fromCharCode(kObjectReplacementChar) * values.length);

  static const int kObjectReplacementChar = 0xFFFE;

  List<T> values;

  final Widget Function(BuildContext context, T data) chipBuilder;

  void updateValues(List<T> values) {
    if (values.length != this.values.length) {
      final String char = String.fromCharCode(kObjectReplacementChar);
      final int length = values.length;
      value = TextEditingValue(
        text: char * length,
        selection: TextSelection.collapsed(offset: length),
      );
      this.values = values;
    }
  }

  String get textWithoutReplacements {
    final String char = String.fromCharCode(kObjectReplacementChar);
    return text.replaceAll(RegExp(char), '');
  }

  String get textWithReplacements => text;

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    final TextStyle chipStyle = (style ?? const TextStyle()).copyWith(
      height: 1.5, // Ensures consistent line height
    );

    final Iterable<WidgetSpan> chipWidgets = values.map(
      (T v) => WidgetSpan(
        child: chipBuilder(context, v),
        alignment: PlaceholderAlignment.middle,
        style: chipStyle,
      ),
    );

    return TextSpan(
      style: style,
      children: <InlineSpan>[
        ...chipWidgets,
        if (textWithoutReplacements.isNotEmpty)
          TextSpan(text: textWithoutReplacements),
      ],
    );
  }
}

class TherapySuggestion extends StatelessWidget {
  const TherapySuggestion(this.therapy, {super.key, this.onTap});

  final String therapy;
  final ValueChanged<String>? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap?.call(therapy),
      child: Chip(
        backgroundColor: Colors.purple,
        labelStyle: const TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        label: Text(therapy),
      ),
    );
  }
}

class TherapyInputChip extends StatelessWidget {
  const TherapyInputChip({
    super.key,
    required this.therapy,
    required this.onDeleted,
    required this.onSelected,
  });

  final String therapy;
  final ValueChanged<String> onDeleted;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 3),
      child: InputChip(
        backgroundColor: Colors.purple,
        labelStyle: const TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        key: ObjectKey(therapy),
        label: Text(therapy),
        // TODO
        // visualDensity: VisualDensity.compact,
        onSelected: (bool value) => onDeleted(therapy),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: const EdgeInsets.all(2),
      ),
    );
  }
}
