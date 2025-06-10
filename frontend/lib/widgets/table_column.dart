// lib/widgets/table_column.dart

import 'package:flutter/material.dart';

/// Defines one column in the generic data table.
class TableColumn<T> {
  /// Header label shown in the table.
  final String title;

  /// Field key used to pull data out of the row (via dynamic indexing),
  /// or passed to sorting/filter callbacks.
  final String field;

  /// Whether tapping the header should allow sorting.
  final bool sortable;

  /// Whether to show a little filter icon in the header.
  final bool filterable;

  /// Columns marked frozen will be placed at the start and can be pinned
  /// when horizontal-scrolling. (Implementation in the table widget.)
  final bool frozen;

  /// At runtime you can toggle this to hide/show the column.
  bool hidden;

  /// Optional builder for custom cell content. If null, we do
  /// `Text((row as dynamic)[field]?.toString() ?? '')`.
  final Widget Function(T row)? cellBuilder;

  /// Note: removed `const` here so that `hidden` can remain mutable.
  TableColumn({
    required this.title,
    required this.field,
    this.sortable = false,
    this.filterable = false,
    this.frozen = false,
    this.hidden = false,
    this.cellBuilder,
  });
}
