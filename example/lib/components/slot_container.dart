import 'package:flutter/material.dart';

class SlotContainer extends StatefulWidget {
  final Color containerColor;
  final Color containerBorderColor;
  final String slotTime;
  final Color slotTimeColor;
  final void Function()? onTap;

  const SlotContainer(
      {Key? key,
      required this.containerColor,
      required this.containerBorderColor,
      required this.slotTime,
      required this.onTap,
      this.slotTimeColor = Colors.black})
      : super(key: key);

  @override
  State<SlotContainer> createState() => _SlotContainerState();
}

class _SlotContainerState extends State<SlotContainer> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: widget.containerColor,
          border: Border.all(color: widget.containerBorderColor),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
            child: Text(widget.slotTime,
                style: TextStyle(
                  color: widget.slotTimeColor,
                ))),
      ),
    );
  }
}
