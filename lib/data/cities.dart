class City {
  final String name;
  final String state;
  final double latitude;
  final double longitude;
  final double utcOffset; // IST = 5.5 for all Indian cities
  // Approximate sunrise/sunset offsets from 6:00 AM in minutes
  // (fine-tuned per lat — we'll compute real sunrise in a later step)
  final int sunriseMinutesFromMidnight; // default sunrise approx
  final int sunsetMinutesFromMidnight;  // default sunset approx

  const City({
    required this.name,
    required this.state,
    required this.latitude,
    required this.longitude,
    required this.utcOffset,
    this.sunriseMinutesFromMidnight = 360, // 6:00 AM default
    this.sunsetMinutesFromMidnight = 1110, // 6:30 PM default
  });
}

const List<City> indianCities = [
  // Maharashtra
  City(name: 'Mumbai',       state: 'Maharashtra',  latitude: 19.0760, longitude: 72.8777, utcOffset: 5.5, sunriseMinutesFromMidnight: 373, sunsetMinutesFromMidnight: 1113),
  City(name: 'Pune',         state: 'Maharashtra',  latitude: 18.5204, longitude: 73.8567, utcOffset: 5.5, sunriseMinutesFromMidnight: 371, sunsetMinutesFromMidnight: 1111),
  City(name: 'Nagpur',       state: 'Maharashtra',  latitude: 21.1458, longitude: 79.0882, utcOffset: 5.5, sunriseMinutesFromMidnight: 354, sunsetMinutesFromMidnight: 1094),
  City(name: 'Nashik',       state: 'Maharashtra',  latitude: 19.9975, longitude: 73.7898, utcOffset: 5.5, sunriseMinutesFromMidnight: 368, sunsetMinutesFromMidnight: 1108),
  City(name: 'Aurangabad',   state: 'Maharashtra',  latitude: 19.8762, longitude: 75.3433, utcOffset: 5.5, sunriseMinutesFromMidnight: 364, sunsetMinutesFromMidnight: 1104),

  // Delhi & NCR
  City(name: 'New Delhi',    state: 'Delhi',        latitude: 28.6139, longitude: 77.2090, utcOffset: 5.5, sunriseMinutesFromMidnight: 363, sunsetMinutesFromMidnight: 1124),
  City(name: 'Noida',        state: 'Uttar Pradesh',latitude: 28.5355, longitude: 77.3910, utcOffset: 5.5, sunriseMinutesFromMidnight: 363, sunsetMinutesFromMidnight: 1123),
  City(name: 'Gurgaon',      state: 'Haryana',      latitude: 28.4595, longitude: 77.0266, utcOffset: 5.5, sunriseMinutesFromMidnight: 364, sunsetMinutesFromMidnight: 1125),

  // Uttar Pradesh
  City(name: 'Lucknow',      state: 'Uttar Pradesh',latitude: 26.8467, longitude: 80.9462, utcOffset: 5.5, sunriseMinutesFromMidnight: 354, sunsetMinutesFromMidnight: 1114),
  City(name: 'Varanasi',     state: 'Uttar Pradesh',latitude: 25.3176, longitude: 82.9739, utcOffset: 5.5, sunriseMinutesFromMidnight: 348, sunsetMinutesFromMidnight: 1108),
  City(name: 'Prayagraj',    state: 'Uttar Pradesh',latitude: 25.4358, longitude: 81.8463, utcOffset: 5.5, sunriseMinutesFromMidnight: 350, sunsetMinutesFromMidnight: 1110),
  City(name: 'Agra',         state: 'Uttar Pradesh',latitude: 27.1767, longitude: 78.0081, utcOffset: 5.5, sunriseMinutesFromMidnight: 360, sunsetMinutesFromMidnight: 1120),
  City(name: 'Mathura',      state: 'Uttar Pradesh',latitude: 27.4924, longitude: 77.6737, utcOffset: 5.5, sunriseMinutesFromMidnight: 361, sunsetMinutesFromMidnight: 1121),

  // Gujarat
  City(name: 'Ahmedabad',    state: 'Gujarat',      latitude: 23.0225, longitude: 72.5714, utcOffset: 5.5, sunriseMinutesFromMidnight: 375, sunsetMinutesFromMidnight: 1115),
  City(name: 'Surat',        state: 'Gujarat',      latitude: 21.1702, longitude: 72.8311, utcOffset: 5.5, sunriseMinutesFromMidnight: 374, sunsetMinutesFromMidnight: 1114),
  City(name: 'Vadodara',     state: 'Gujarat',      latitude: 22.3072, longitude: 73.1812, utcOffset: 5.5, sunriseMinutesFromMidnight: 373, sunsetMinutesFromMidnight: 1113),
  City(name: 'Rajkot',       state: 'Gujarat',      latitude: 22.3039, longitude: 70.8022, utcOffset: 5.5, sunriseMinutesFromMidnight: 379, sunsetMinutesFromMidnight: 1119),
  City(name: 'Dwarka',       state: 'Gujarat',      latitude: 22.2442, longitude: 68.9685, utcOffset: 5.5, sunriseMinutesFromMidnight: 383, sunsetMinutesFromMidnight: 1123),

  // Rajasthan
  City(name: 'Jaipur',       state: 'Rajasthan',    latitude: 26.9124, longitude: 75.7873, utcOffset: 5.5, sunriseMinutesFromMidnight: 366, sunsetMinutesFromMidnight: 1126),
  City(name: 'Jodhpur',      state: 'Rajasthan',    latitude: 26.2389, longitude: 73.0243, utcOffset: 5.5, sunriseMinutesFromMidnight: 372, sunsetMinutesFromMidnight: 1132),
  City(name: 'Udaipur',      state: 'Rajasthan',    latitude: 24.5854, longitude: 73.7125, utcOffset: 5.5, sunriseMinutesFromMidnight: 371, sunsetMinutesFromMidnight: 1131),
  City(name: 'Ujjain',       state: 'Madhya Pradesh',latitude: 23.1765,longitude: 75.7885, utcOffset: 5.5, sunriseMinutesFromMidnight: 367, sunsetMinutesFromMidnight: 1127),

  // Madhya Pradesh
  City(name: 'Bhopal',       state: 'Madhya Pradesh',latitude: 23.2599,longitude: 77.4126, utcOffset: 5.5, sunriseMinutesFromMidnight: 363, sunsetMinutesFromMidnight: 1123),
  City(name: 'Indore',       state: 'Madhya Pradesh',latitude: 22.7196,longitude: 75.8577, utcOffset: 5.5, sunriseMinutesFromMidnight: 367, sunsetMinutesFromMidnight: 1127),

  // Karnataka
  City(name: 'Bengaluru',    state: 'Karnataka',    latitude: 12.9716, longitude: 77.5946, utcOffset: 5.5, sunriseMinutesFromMidnight: 363, sunsetMinutesFromMidnight: 1083),
  City(name: 'Mysuru',       state: 'Karnataka',    latitude: 12.2958, longitude: 76.6394, utcOffset: 5.5, sunriseMinutesFromMidnight: 364, sunsetMinutesFromMidnight: 1084),
  City(name: 'Mangaluru',    state: 'Karnataka',    latitude: 12.9141, longitude: 74.8560, utcOffset: 5.5, sunriseMinutesFromMidnight: 368, sunsetMinutesFromMidnight: 1088),
  City(name: 'Hubballi',     state: 'Karnataka',    latitude: 15.3647, longitude: 75.1240, utcOffset: 5.5, sunriseMinutesFromMidnight: 365, sunsetMinutesFromMidnight: 1085),

  // Tamil Nadu
  City(name: 'Chennai',      state: 'Tamil Nadu',   latitude: 13.0827, longitude: 80.2707, utcOffset: 5.5, sunriseMinutesFromMidnight: 355, sunsetMinutesFromMidnight: 1075),
  City(name: 'Coimbatore',   state: 'Tamil Nadu',   latitude: 11.0168, longitude: 76.9558, utcOffset: 5.5, sunriseMinutesFromMidnight: 361, sunsetMinutesFromMidnight: 1081),
  City(name: 'Madurai',      state: 'Tamil Nadu',   latitude: 9.9252,  longitude: 78.1198, utcOffset: 5.5, sunriseMinutesFromMidnight: 358, sunsetMinutesFromMidnight: 1078),
  City(name: 'Tirupati',     state: 'Andhra Pradesh',latitude: 13.6288,longitude: 79.4192, utcOffset: 5.5, sunriseMinutesFromMidnight: 354, sunsetMinutesFromMidnight: 1074),

  // Andhra Pradesh & Telangana
  City(name: 'Hyderabad',    state: 'Telangana',    latitude: 17.3850, longitude: 78.4867, utcOffset: 5.5, sunriseMinutesFromMidnight: 357, sunsetMinutesFromMidnight: 1097),
  City(name: 'Visakhapatnam',state: 'Andhra Pradesh',latitude: 17.6868,longitude: 83.2185, utcOffset: 5.5, sunriseMinutesFromMidnight: 346, sunsetMinutesFromMidnight: 1086),
  City(name: 'Vijayawada',   state: 'Andhra Pradesh',latitude: 16.5062,longitude: 80.6480, utcOffset: 5.5, sunriseMinutesFromMidnight: 354, sunsetMinutesFromMidnight: 1094),

  // Kerala
  City(name: 'Thiruvananthapuram', state: 'Kerala', latitude: 8.5241,  longitude: 76.9366, utcOffset: 5.5, sunriseMinutesFromMidnight: 361, sunsetMinutesFromMidnight: 1081),
  City(name: 'Kochi',        state: 'Kerala',       latitude: 9.9312,  longitude: 76.2673, utcOffset: 5.5, sunriseMinutesFromMidnight: 362, sunsetMinutesFromMidnight: 1082),
  City(name: 'Kozhikode',    state: 'Kerala',       latitude: 11.2588, longitude: 75.7804, utcOffset: 5.5, sunriseMinutesFromMidnight: 363, sunsetMinutesFromMidnight: 1083),

  // West Bengal
  City(name: 'Kolkata',      state: 'West Bengal',  latitude: 22.5726, longitude: 88.3639, utcOffset: 5.5, sunriseMinutesFromMidnight: 331, sunsetMinutesFromMidnight: 1091),

  // Bihar & Jharkhand
  City(name: 'Patna',        state: 'Bihar',        latitude: 25.5941, longitude: 85.1376, utcOffset: 5.5, sunriseMinutesFromMidnight: 340, sunsetMinutesFromMidnight: 1100),
  City(name: 'Gaya',         state: 'Bihar',        latitude: 24.7955, longitude: 85.0002, utcOffset: 5.5, sunriseMinutesFromMidnight: 341, sunsetMinutesFromMidnight: 1101),

  // Punjab & Haryana
  City(name: 'Amritsar',     state: 'Punjab',       latitude: 31.6340, longitude: 74.8723, utcOffset: 5.5, sunriseMinutesFromMidnight: 371, sunsetMinutesFromMidnight: 1151),
  City(name: 'Chandigarh',   state: 'Punjab',       latitude: 30.7333, longitude: 76.7794, utcOffset: 5.5, sunriseMinutesFromMidnight: 367, sunsetMinutesFromMidnight: 1147),
  City(name: 'Ludhiana',     state: 'Punjab',       latitude: 30.9010, longitude: 75.8573, utcOffset: 5.5, sunriseMinutesFromMidnight: 368, sunsetMinutesFromMidnight: 1148),

  // Himachal & Uttarakhand
  City(name: 'Shimla',       state: 'Himachal Pradesh', latitude: 31.1048, longitude: 77.1734, utcOffset: 5.5, sunriseMinutesFromMidnight: 364, sunsetMinutesFromMidnight: 1144),
  City(name: 'Haridwar',     state: 'Uttarakhand',  latitude: 29.9457, longitude: 78.1642, utcOffset: 5.5, sunriseMinutesFromMidnight: 360, sunsetMinutesFromMidnight: 1140),
  City(name: 'Rishikesh',    state: 'Uttarakhand',  latitude: 30.0869, longitude: 78.2676, utcOffset: 5.5, sunriseMinutesFromMidnight: 360, sunsetMinutesFromMidnight: 1140),

  // Goa
  City(name: 'Panaji',       state: 'Goa',          latitude: 15.4909, longitude: 73.8278, utcOffset: 5.5, sunriseMinutesFromMidnight: 369, sunsetMinutesFromMidnight: 1109),

  // Assam & Northeast
  City(name: 'Guwahati',     state: 'Assam',        latitude: 26.1445, longitude: 91.7362, utcOffset: 5.5, sunriseMinutesFromMidnight: 322, sunsetMinutesFromMidnight: 1082),
];