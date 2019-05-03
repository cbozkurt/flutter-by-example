// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vector_math/vector_math_64.dart';

void main() => runApp(MyApp());

final yellow = Color(0xFFFFFF00);

final textStyle = TextStyle(
  color: yellow,
  fontSize: 24,
);

final crawlString = """
Lorem ipsum dolor sit amet, in sea illud veritus suavitate, mutat ullum ut pro. Fabulas accusata cu ius, nec an quem vituperatoribus, ex mel doctus splendide. Eam habeo fabellas ne, principes reprimique sea ad. Et vim scaevola accommodare. Vim ad eius adhuc homero. Maiestatis elaboraret ei nam.

An usu fugit recteque ullamcorper, ea eos essent molestiae reprimique. Vocibus instructior ne nec. Justo reprehendunt ut has, vel ea clita signiferumque. Sale disputationi ut quo.

Cum nibh assentior tincidunt ad. Mei te accusam convenire partiendo, facilisi expetenda inciderint ei has. Falli corrumpit an per, no vis vidisse accusata, nibh noster dolores sea ex. Singulis accusamus at cum, tation aliquip mediocritatem duo et. Ei mel suas argumentum, pri no purto ignota quaerendum.
""";

final textTheme = TextTheme(display1: textStyle);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      color: Color(0xFF000000),
      builder: (context, _) => CrawlPage(),
    );
  }
}

class CrawlPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Perspective(child: Crawler());
  }
}

class Crawler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: _CrawlScrollPhysics(),
      children: [
        Text(
          crawlString,
          style: textStyle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class Perspective extends StatelessWidget {
  Perspective({this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.002)
        ..rotateX(-3.14 / 3.5),
      alignment: FractionalOffset.center,
      child: child,
    );
  }
}

class _CrawlScrollPhysics extends ScrollPhysics {
  _CrawlScrollPhysics() : super(parent: AlwaysScrollableScrollPhysics());

  double get minFlingVelocity => 10;

  @override
  ScrollPhysics applyTo(ScrollPhysics ancestor) {
    return _CrawlScrollPhysics();
  }

  @override
  Simulation createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    if (parent == null) return null;
    return _CrawlScrollSimulation(position.pixels, velocity / 2);
  }
}

class _CrawlScrollSimulation extends Simulation {
  final double initial;
  final double velocity;

  _CrawlScrollSimulation(this.initial, this.velocity);

  @override
  double dx(double time) => velocity;

  @override
  bool isDone(double time) => false;

  @override
  double x(double time) {
    return initial + velocity * time;
  }
}
