import 'package:flutter/material.dart';

/// Spacing follows the body type size, so nothing in the layout is a raw pixel.
class Em {
  Em.of(BuildContext context)
      : em = MediaQuery.textScalerOf(context).scale(
          Theme.of(context).textTheme.bodyLarge?.fontSize ?? 17,
        );

  final double em;

  double call(double steps) => em * steps;
}
