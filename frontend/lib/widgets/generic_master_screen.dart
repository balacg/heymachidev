// lib/widgets/generic_master_screen.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GenericMasterScreen<T> extends StatefulWidget {
  final String title;
  final String apiEndpoint;
  final T Function(Map<String, dynamic>) fromJson;
  final Map<String, dynamic> Function(T) toJson;
  final List<Widget> Function(T item, void Function(T) onChanged) buildFormFields;
  final List<String> Function(T item) displayFields;

  const GenericMasterScreen({
    super.key,
    required this.title,
    required this.apiEndpoint,
    required this.fromJson,
    required this.toJson,
    required this.buildFormFields,
    required this.displayFields,
  });

  @override
  State<GenericMasterScreen<T>> createState() => _GenericMasterScreenState<T>();
}

class _GenericMasterScreenState<T> extends State<GenericMasterScreen<T>> {
  List<T> items = [];
  bool loading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      loading = true;
      error = null;
    });
    try {
      final res = await http.get(Uri.parse('http://localhost:8000${widget.apiEndpoint}'));
      if (res.statusCode == 200) {
        final List<dynamic> data = jsonDecode(res.body);
        items = data.map((json) => widget.fromJson(json)).toList();
      } else {
        error = 'Failed to fetch data';
      }
    } catch (e) {
      error = e.toString();
    }
    setState(() => loading = false);
  }

  void _showForm({T? item}) {
    final isEdit = item != null;
    late T model = item ?? widget.fromJson({});

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(isEdit ? 'Edit' : 'Add ${widget.title}'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: widget.buildFormFields(model, (updated) {
              model = updated;
            }),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              final body = jsonEncode(widget.toJson(model));
              final url = isEdit
                  ? Uri.parse('http://localhost:8000${widget.apiEndpoint}/${(widget.toJson(model)['id'])}')
                  : Uri.parse('http://localhost:8000${widget.apiEndpoint}');
              final res = isEdit
                  ? await http.put(url, body: body, headers: {'Content-Type': 'application/json'})
                  : await http.post(url, body: body, headers: {'Content-Type': 'application/json'});
              if (res.statusCode == 200 || res.statusCode == 201) {
                Navigator.of(ctx).pop();
                _load();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Save failed')));
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _delete(T item) async {
    final id = widget.toJson(item)['id'];
    final res = await http.delete(Uri.parse('http://localhost:8000${widget.apiEndpoint}/$id'));
    if (res.statusCode == 200) {
      _load();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Delete failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : error != null
              ? Center(child: Text(error!))
              : ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (_, index) {
                    final item = items[index];
                    final fields = widget.displayFields(item);
                    return ListTile(
                      title: Text(fields.first),
                      subtitle: Text(fields.skip(1).join(' | ')),
                      trailing: PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'edit') _showForm(item: item);
                          if (value == 'delete') _delete(item);
                        },
                        itemBuilder: (_) => const [
                          PopupMenuItem(value: 'edit', child: Text('Edit')),
                          PopupMenuItem(value: 'delete', child: Text('Delete')),
                        ],
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
