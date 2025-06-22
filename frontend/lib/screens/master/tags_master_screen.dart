// lib/screens/master/tags_master_screen.dart

import 'package:flutter/material.dart';
import '../../models/tag.dart';
import '../../services/tag_service.dart';
import '../../widgets/generic_data_table.dart';
import '../../widgets/table_column.dart';

class TagsMasterScreen extends StatefulWidget {
  const TagsMasterScreen({super.key});

  @override
  State<TagsMasterScreen> createState() => _TagsMasterScreenState();
}

class _TagsMasterScreenState extends State<TagsMasterScreen> {
  List<Tag> tags = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTags();
  }

  void fetchTags() async {
    try {
      final data = await TagService.fetchTags("BIZ-RES-0001");
      setState(() {
        tags = data;
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Failed to load tags: $e");
    }
  }

  
  void _onDelete(Tag tag) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: Text("Are you sure you want to delete '${tag.tagValue}'?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text("Delete"),
          ),
        ],
      ),
    );

    if (shouldDelete != true) return;

    try {
      await TagService.deleteTag(tag.id!);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Tag '${tag.tagValue}' deleted")),
      );
      fetchTags(); // refresh table
    } catch (e) {
      debugPrint("Failed to delete tag: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to delete tag")),
      );
    }
  }



  void _onAddNew() {
    showTagFormDialog(
      context,
      onSubmit: (tag) async {
        await TagService.createTag(tag);
        fetchTags();
      },
    );
  }

  void _onEdit(Tag tag) {
    showTagFormDialog(
      context,
      existingTag: tag,
      onSubmit: (updatedTag) async {
        if (updatedTag.id != null) {
          await TagService.updateTag(updatedTag.id!, updatedTag);
          fetchTags();
        }
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tags Master")),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddNew,
        child: const Icon(Icons.add),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : GenericDataTable<Tag>(
              columns: [
                TableColumn<Tag>(title: 'Tag Type', field: 'tag_type'),
                TableColumn<Tag>(title: 'Tag Value', field: 'tag_value'),
                TableColumn<Tag>(title: 'Business', field: 'business_id'),
                TableColumn<Tag>(
                  title: 'Active',
                  field: 'is_active',
                  cellBuilder: (tag) => Icon(
                    tag.isActive ? Icons.check_circle : Icons.cancel,
                    color: tag.isActive ? Colors.green : Colors.red,
                  ),
                ),
                TableColumn<Tag>(
                  title: 'Actions',
                  field: '',
                  cellBuilder: (tag) => Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, size: 20),
                        onPressed: () => _onEdit(tag),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, size: 20),
                        onPressed: () => _onDelete(tag),
                      ),
                    ],
                  ),
                ),
              ],
              rows: tags,
            ),
    );
  }

    Future<void> showTagFormDialog(BuildContext context, {
    Tag? existingTag,
    required Function(Tag) onSubmit,
  }) async {
      final _typeController = TextEditingController(text: existingTag?.tagType ?? '');
      final _valueController = TextEditingController(text: existingTag?.tagValue ?? '');
      bool _isActive = existingTag?.isActive ?? true;

      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(existingTag == null ? "Add Tag" : "Edit Tag"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _typeController,
                decoration: const InputDecoration(labelText: 'Tag Type'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _valueController,
                decoration: const InputDecoration(labelText: 'Tag Value'),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text('Active'),
                  Switch(
                    value: _isActive,
                    onChanged: (v) => _isActive = v,
                  ),
                ],
              )
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
            ElevatedButton(
              onPressed: () {
                final tag = Tag(
                  id: existingTag?.id,
                  tagType: _typeController.text.trim(),
                  tagValue: _valueController.text.trim(),
                  businessId: "BIZ-RES-0001",
                  isActive: _isActive,
                );
                Navigator.pop(context);
                onSubmit(tag);
              },
              child: const Text("Save"),
            )
          ],
        ),
      );
    }


}
