class Note {

  final String id;
  final String title;
  final String category;
  final String problemDescription;
  final String solution;

  Note({
    required this.id,
    required this.title,
    required this.category,
    required this.problemDescription,
    required this.solution,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      problemDescription: json['problem'],
      solution: json['solution'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'problem': problemDescription,
      'solution': solution,
    };
  }
}