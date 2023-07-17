import 'package:flutter/material.dart';

class SwitchWidget extends StatefulWidget {
  SwitchWidget(
      {super.key,
      this.thumIcon,
      this.thumColor,
      this.backgroundactiveColor,
      this.backgrouninactiveColor,
      this.stateSwitch,
      this.defaultStatusSwitch,
      this.borderSwitch});

  bool? defaultStatusSwitch;
  MaterialStateProperty<Icon>? thumIcon;
  MaterialStateProperty<Color>? thumColor;
  Color? backgroundactiveColor;
  Color? backgrouninactiveColor;
  Color? circleColorEnabled;
  Color? circleColorDisabled;

  Color? borderSwitch;
  Function(bool)? stateSwitch;

  @override
  State<SwitchWidget> createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  bool _isEnabled = false;
  MaterialStateProperty<Color>? statePropertyColor;
  MaterialStateProperty<Icon>? statePropertyIcon;
  MaterialStateProperty<Color>? statePropertyTrackOutline;

  @override
  void initState() {
    super.initState();
    _isEnabled = widget.defaultStatusSwitch ?? false;
    statePropertyIcon = MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    });

    statePropertyColor = MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return widget.circleColorEnabled ?? Colors.white;
      }
      return widget.circleColorDisabled ??
          widget.circleColorEnabled ??
          Colors.white;
    });

    statePropertyTrackOutline = MaterialStateProperty.resolveWith((states) {
      return widget.borderSwitch ?? Colors.transparent;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
        activeColor: widget.backgroundactiveColor ?? Colors.greenAccent,
        inactiveTrackColor:
            widget.backgrouninactiveColor ?? Colors.grey, // background nền
        thumbColor: statePropertyColor, // Color tròn tròn

        trackOutlineColor: statePropertyTrackOutline,
        value: _isEnabled,
        onChanged: (status) {
          widget.stateSwitch?.call(status);
          setState(() {
            _isEnabled = status;
          });
        });
  }
}
