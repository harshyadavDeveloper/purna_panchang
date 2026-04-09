class Festival {
  final String name;
  final String nameHindi;
  final int month;
  final int day;
  final String description;

  const Festival({
    required this.name,
    required this.nameHindi,
    required this.month,
    required this.day,
    required this.description,
  });
}

// Static festivals for 2025 — we'll make this dynamic in v2
const List<Festival> festivals2025 = [
  // January
  Festival(name: 'Makar Sankranti', nameHindi: 'मकर संक्रांति', month: 1, day: 14, description: 'Sun enters Capricorn'),
  Festival(name: 'Pongal', nameHindi: 'पोंगल', month: 1, day: 14, description: 'Harvest festival of Tamil Nadu'),
  Festival(name: 'Republic Day', nameHindi: 'गणतंत्र दिवस', month: 1, day: 26, description: 'National holiday'),

  // February
  Festival(name: 'Vasant Panchami', nameHindi: 'वसंत पंचमी', month: 2, day: 2, description: 'Saraswati Puja'),
  Festival(name: 'Maha Shivratri', nameHindi: 'महाशिवरात्रि', month: 2, day: 26, description: 'Night of Lord Shiva'),

  // March
  Festival(name: 'Holi', nameHindi: 'होली', month: 3, day: 14, description: 'Festival of colors'),
  Festival(name: 'Holika Dahan', nameHindi: 'होलिका दहन', month: 3, day: 13, description: 'Eve of Holi'),

  // April
  Festival(name: 'Ram Navami', nameHindi: 'राम नवमी', month: 4, day: 6, description: 'Birthday of Lord Ram'),
  Festival(name: 'Hanuman Jayanti', nameHindi: 'हनुमान जयंती', month: 4, day: 12, description: 'Birthday of Lord Hanuman'),
  Festival(name: 'Baisakhi', nameHindi: 'बैसाखी', month: 4, day: 14, description: 'Harvest festival & Sikh New Year'),
  Festival(name: 'Ugadi', nameHindi: 'उगादि', month: 4, day: 30, description: 'Telugu & Kannada New Year'),

  // May
  Festival(name: 'Buddha Purnima', nameHindi: 'बुद्ध पूर्णिमा', month: 5, day: 12, description: 'Birth of Gautama Buddha'),
  Festival(name: 'Akshaya Tritiya', nameHindi: 'अक्षय तृतीया', month: 5, day: 10, description: 'Most auspicious day for new beginnings'),

  // June
  Festival(name: 'Vat Savitri', nameHindi: 'वट सावित्री', month: 6, day: 2, description: 'Observed by married Hindu women'),
  Festival(name: 'Ganga Dussehra', nameHindi: 'गंगा दशहरा', month: 6, day: 5, description: 'Descent of Ganga to Earth'),

  // July
  Festival(name: 'Guru Purnima', nameHindi: 'गुरु पूर्णिमा', month: 7, day: 10, description: 'Honoring spiritual teachers'),
  Festival(name: 'Ashadhi Ekadashi', nameHindi: 'आषाढी एकादशी', month: 7, day: 17, description: 'Wari pilgrimage to Pandharpur'),

  // August
  Festival(name: 'Nag Panchami', nameHindi: 'नाग पंचमी', month: 8, day: 1, description: 'Worship of serpent deities'),
  Festival(name: 'Raksha Bandhan', nameHindi: 'रक्षाबंधन', month: 8, day: 9, description: 'Bond between brothers and sisters'),
  Festival(name: 'Independence Day', nameHindi: 'स्वतंत्रता दिवस', month: 8, day: 15, description: 'National holiday'),
  Festival(name: 'Krishna Janmashtami', nameHindi: 'जन्माष्टमी', month: 8, day: 16, description: 'Birthday of Lord Krishna'),
  Festival(name: 'Ganesh Chaturthi', nameHindi: 'गणेश चतुर्थी', month: 8, day: 27, description: 'Birthday of Lord Ganesha'),

  // September
  Festival(name: 'Ganesh Visarjan', nameHindi: 'गणेश विसर्जन', month: 9, day: 5, description: 'Last day of Ganesh festival'),
  Festival(name: 'Onam', nameHindi: 'ओणम', month: 9, day: 5, description: 'Harvest festival of Kerala'),
  Festival(name: 'Pitru Paksha begins', nameHindi: 'पितृ पक्ष', month: 9, day: 7, description: '16-day period of ancestor worship'),

  // October
  Festival(name: 'Navratri begins', nameHindi: 'नवरात्रि', month: 10, day: 2, description: '9 nights of Goddess Durga'),
  Festival(name: 'Dussehra', nameHindi: 'दशहरा', month: 10, day: 2, description: 'Victory of Ram over Ravan'),
  Festival(name: 'Karva Chauth', nameHindi: 'करवा चौथ', month: 10, day: 20, description: 'Fast by married women for husbands'),
  Festival(name: 'Gandhi Jayanti', nameHindi: 'गांधी जयंती', month: 10, day: 2, description: 'Birthday of Mahatma Gandhi'),

  // November
  Festival(name: 'Dhanteras', nameHindi: 'धनतेरस', month: 10, day: 29, description: 'First day of Diwali celebrations'),
  Festival(name: 'Diwali', nameHindi: 'दीपावली', month: 10, day: 20, description: 'Festival of lights'),
  Festival(name: 'Govardhan Puja', nameHindi: 'गोवर्धन पूजा', month: 10, day: 21, description: 'Worship of Govardhan hill'),
  Festival(name: 'Bhai Dooj', nameHindi: 'भाई दूज', month: 10, day: 22, description: 'Celebrating sibling bond'),
  Festival(name: 'Dev Uthani Ekadashi', nameHindi: 'देव उठनी एकादशी', month: 11, day: 1, description: 'Lord Vishnu wakes from sleep'),
  Festival(name: 'Kartik Purnima', nameHindi: 'कार्तिक पूर्णिमा', month: 11, day: 5, description: 'Holy full moon of Kartik'),
  Festival(name: 'Guru Nanak Jayanti', nameHindi: 'गुरु नानक जयंती', month: 11, day: 5, description: 'Birthday of Guru Nanak Dev'),

  // December
  Festival(name: 'Gita Jayanti', nameHindi: 'गीता जयंती', month: 12, day: 1, description: 'Anniversary of Bhagavad Gita'),
  Festival(name: 'Christmas', nameHindi: 'क्रिसमस', month: 12, day: 25, description: 'National holiday'),
];

List<Festival> festivalsForDate(int month, int day) {
  return festivals2025
      .where((f) => f.month == month && f.day == day)
      .toList();
}