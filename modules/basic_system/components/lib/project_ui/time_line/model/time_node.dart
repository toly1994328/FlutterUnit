class TimeNode {
  final String title;
  final String time;
  final String? year;
  final String content;
  final String? imageUrl;

  TimeNode(
      {required this.title,
      required this.time,
       this.year,
      required this.content,
        this.imageUrl});

  @override
  String toString() {
    return 'TimeNode{title: $title, time: $time, content: $content, imageUrl: $imageUrl}';
  }
}
