int CalculateReadingTime(String content) {

  final wordCount =  content.split(  RegExp(r'\s+')).length;

  final readingTimeMinutes  = wordCount / 225 ;

  return readingTimeMinutes.ceil();
  // Average reading speed is about 200-250 words per minute
}