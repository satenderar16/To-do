

class TodoElement {
  String? title;
  String? note;
  List<String>? tags;

  TodoElement({
     this.title,
     this.note,
     this.tags,
  });

  // Factory method for creating a TodoElement from JSON
  factory TodoElement.fromJson(Map<String, dynamic> json) {
    return TodoElement(
      title: json['title'] as String,
      note: json['note'] as String,
      tags: List<String>.from(json['tags'] ?? []),
    );
  }

  // Method to convert TodoElement to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'note': note,
      'tags': tags,
    };
  }
}
