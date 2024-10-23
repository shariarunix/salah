class HadithModel {
  final String title;
  final String narrator;
  final String content;
  final String reference;

  HadithModel({
    required this.title,
    required this.narrator,
    required this.content,
    required this.reference,
  });
}

HadithModel demoHadit = HadithModel(
  title: 'Sahih Hadith',
  narrator: 'Amr b. Dinar said',
  content: 'We asked Ibn Umar about a person who cam for Umra and Circumambulated the House, but he did not run between al-Safa and al-Marwa whether he is allowed to (put off uhram) and have intercourse with his wife. He replied: Allah\'s Messenger (peace upon him) circumambulated the House seven times and offered two rak\'ahs of prayer after staying(at \' Arafat), and ran between al-Safa and al-Marwa seven times. "Verily there is in Allah\'s Messenger (peace upon him) a model pattern for you"(xxxill.21)',
  reference: 'Sahih Muslim, 1234 a',
);