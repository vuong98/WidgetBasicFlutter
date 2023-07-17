import 'package:flutter/material.dart';
import 'package:widgetscomponent/utils/text_style.dart';
import 'package:widgetscomponent/widgets/switch_widget.dart';

class ItemLabelSwitch extends StatefulWidget {
  const ItemLabelSwitch(
      {super.key,
      this.labelText,
      this.textStyle,
      this.widthFromLabelToSwitch,
      this.stateSwitch,
      this.listenerChangeValue,
      this.switchbackgroundactiveColor,
      this.switchbackgroundinactiveColor});

  final String? labelText;
  final TextStyle? textStyle;
  final double? widthFromLabelToSwitch;
  final bool? stateSwitch;

  final Color? switchbackgroundactiveColor;
  final Color? switchbackgroundinactiveColor;

  final Function(bool)? listenerChangeValue;

  @override
  State<ItemLabelSwitch> createState() => _ItemLabelSwitchState();
}

class _ItemLabelSwitchState extends State<ItemLabelSwitch> {
  bool stateCurrentSwitch = false;

  @override
  void initState() {
    super.initState();

    stateCurrentSwitch = widget.stateSwitch ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
            '${widget.labelText} (${(stateCurrentSwitch == true) ? 'on' : 'off'})',
            style: widget.textStyle ?? AppTextStyle.textStyle),
        SizedBox(width: widget.widthFromLabelToSwitch ?? 20.0),
        SwitchWidget(
          backgroundactiveColor: widget.switchbackgroundactiveColor,
          backgrouninactiveColor: widget.switchbackgroundinactiveColor,
          defaultStatusSwitch: widget.stateSwitch ?? false,
          stateSwitch: (status) {
            setState(() {
              widget.listenerChangeValue?.call(status);
              stateCurrentSwitch = status;
            });
          },
        )
      ],
    );
  }
}
