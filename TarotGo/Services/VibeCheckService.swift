import Foundation

/// Service responsible for generating consistent daily vibe check data across all devices
class VibeCheckService {
    
    struct CityVibe: Identifiable {
        let id = UUID()
        let cityName: String
        let countryName: String
        let latitude: Double
        let longitude: Double
        let card: TarotCard
        let percentage: Int // How dominant this card is (for visual effect)
    }
    
    // Major cities and capitals around the world
    private static let worldCities = [
        // Europe
        ("Paris", "France", 48.8566, 2.3522),
        ("London", "UK", 51.5074, -0.1278),
        ("Berlin", "Germany", 52.5200, 13.4050),
        ("Madrid", "Spain", 40.4168, -3.7038),
        ("Rome", "Italy", 41.9028, 12.4964),
        ("Warsaw", "Poland", 52.2297, 21.0122),
        ("Kyiv", "Ukraine", 50.4501, 30.5234),
        ("Lviv", "Ukraine", 49.8397, 24.0297),
        ("Barcelona", "Spain", 41.3851, 2.1734),
        ("Moscow", "Russia", 55.7558, 37.6173),
        ("Amsterdam", "Netherlands", 52.3676, 4.9041),
        ("Vienna", "Austria", 48.2082, 16.3738),
        ("Prague", "Czech Republic", 50.0755, 14.4378),
        ("Budapest", "Hungary", 47.4979, 19.0402),
        ("Stockholm", "Sweden", 59.3293, 18.0686),
        ("Oslo", "Norway", 59.9139, 10.7522),
        ("Copenhagen", "Denmark", 55.6761, 12.5683),
        ("Helsinki", "Finland", 60.1699, 24.9384),
        ("Dublin", "Ireland", 53.3498, -6.2603),
        ("Lisbon", "Portugal", 38.7223, -9.1393),
        ("Athens", "Greece", 37.9838, 23.7275),
        ("Brussels", "Belgium", 50.8503, 4.3517),
        ("Zurich", "Switzerland", 47.3769, 8.5417),
        ("Istanbul", "Turkey", 41.0082, 28.9784),
        ("Bucharest", "Romania", 44.4268, 26.1025),
        ("Sofia", "Bulgaria", 42.6977, 23.3219),
        ("Belgrade", "Serbia", 44.7866, 20.4489),
        ("Zagreb", "Croatia", 45.8150, 15.9819),
        ("Ljubljana", "Slovenia", 46.0569, 14.5058),
        ("Bratislava", "Slovakia", 48.1486, 17.1077),
        ("Vilnius", "Lithuania", 54.6872, 25.2797),
        ("Riga", "Latvia", 56.9496, 24.1052),
        ("Tallinn", "Estonia", 59.4370, 24.7536),
        ("Minsk", "Belarus", 53.9045, 27.5615),
        ("Reykjavik", "Iceland", 64.1466, -21.9426),
        ("Luxembourg", "Luxembourg", 49.6116, 6.1319),
        ("Monaco", "Monaco", 43.7384, 7.4246),
        ("Andorra la Vella", "Andorra", 42.5063, 1.5218),
        ("Valletta", "Malta", 35.8989, 14.5146),
        ("Nicosia", "Cyprus", 35.1856, 33.3823),
        ("Chisinau", "Moldova", 47.0105, 28.8638),
        ("Sarajevo", "Bosnia", 43.8564, 18.4131),
        ("Skopje", "North Macedonia", 41.9973, 21.4280),
        ("Podgorica", "Montenegro", 42.4304, 19.2594),
        ("Tirana", "Albania", 41.3275, 19.8187),
        
        // North America
        ("New York", "USA", 40.7128, -74.0060),
        ("San Francisco", "USA", 37.7749, -122.4194),
        ("Los Angeles", "USA", 34.0522, -118.2437),
        ("Chicago", "USA", 41.8781, -87.6298),
        ("Washington DC", "USA", 38.9072, -77.0369),
        ("Toronto", "Canada", 43.6532, -79.3832),
        ("Vancouver", "Canada", 49.2827, -123.1207),
        ("Ottawa", "Canada", 45.4215, -75.6972),
        ("Mexico City", "Mexico", 19.4326, -99.1332),
        ("Havana", "Cuba", 23.1136, -82.3666),
        ("Kingston", "Jamaica", 17.9714, -76.7931),
        ("San Juan", "Puerto Rico", 18.4655, -66.1057),
        ("Santo Domingo", "Dominican Rep.", 18.4861, -69.9312),
        ("Port-au-Prince", "Haiti", 18.5944, -72.3074),
        ("San Salvador", "El Salvador", 13.6929, -89.2182),
        ("Tegucigalpa", "Honduras", 14.0723, -87.1921),
        ("Managua", "Nicaragua", 12.1150, -86.2362),
        ("San José", "Costa Rica", 9.9281, -84.0907),
        ("Panama City", "Panama", 8.9824, -79.5199),
        ("Guatemala City", "Guatemala", 14.6349, -90.5069),
        ("Belize City", "Belize", 17.5045, -88.1962),
        ("Nassau", "Bahamas", 25.0443, -77.3504),
        ("Bridgetown", "Barbados", 13.1132, -59.5988),
        ("Port of Spain", "Trinidad", 10.6549, -61.5019),
        
        // South America
        ("Rio de Janeiro", "Brazil", -22.9068, -43.1729),
        ("Buenos Aires", "Argentina", -34.6037, -58.3816),
        ("São Paulo", "Brazil", -23.5505, -46.6333),
        ("Lima", "Peru", -12.0464, -77.0428),
        ("Bogotá", "Colombia", 4.7110, -74.0721),
        ("Santiago", "Chile", -33.4489, -70.6693),
        ("Brasília", "Brazil", -15.8267, -47.9218),
        ("Caracas", "Venezuela", 10.4806, -66.9036),
        ("Quito", "Ecuador", -0.1807, -78.4678),
        ("La Paz", "Bolivia", -16.5000, -68.1500),
        ("Asunción", "Paraguay", -25.2637, -57.5759),
        ("Montevideo", "Uruguay", -34.9011, -56.1645),
        ("Georgetown", "Guyana", 6.8013, -58.1551),
        ("Paramaribo", "Suriname", 5.8520, -55.2038),
        ("Cayenne", "French Guiana", 4.9227, -52.3269),
        
        // Asia
        ("Tokyo", "Japan", 35.6762, 139.6503),
        ("Seoul", "South Korea", 37.5665, 126.9780),
        ("Beijing", "China", 39.9042, 116.4074),
        ("Shanghai", "China", 31.2304, 121.4737),
        ("Hong Kong", "China", 22.3193, 114.1694),
        ("Singapore", "Singapore", 1.3521, 103.8198),
        ("Bangkok", "Thailand", 13.7563, 100.5018),
        ("Mumbai", "India", 19.0760, 72.8777),
        ("Delhi", "India", 28.7041, 77.1025),
        ("Dubai", "UAE", 25.2048, 55.2708),
        ("Tel Aviv", "Israel", 32.0853, 34.7818),
        ("Riyadh", "Saudi Arabia", 24.7136, 46.6753),
        ("Jakarta", "Indonesia", -6.2088, 106.8456),
        ("Manila", "Philippines", 14.5995, 120.9842),
        ("Kuala Lumpur", "Malaysia", 3.1390, 101.6869),
        ("Hanoi", "Vietnam", 21.0285, 105.8542),
        ("Taipei", "Taiwan", 25.0330, 121.5654),
        ("Yangon", "Myanmar", 16.8661, 96.1951),
        ("Phnom Penh", "Cambodia", 11.5564, 104.9282),
        ("Vientiane", "Laos", 17.9757, 102.6331),
        ("Dhaka", "Bangladesh", 23.8103, 90.4125),
        ("Colombo", "Sri Lanka", 6.9271, 79.8612),
        ("Kabul", "Afghanistan", 34.5553, 69.2075),
        ("Islamabad", "Pakistan", 33.6844, 73.0479),
        ("Kathmandu", "Nepal", 27.7172, 85.3240),
        ("Thimphu", "Bhutan", 27.4728, 89.6393),
        ("Ulaanbaatar", "Mongolia", 47.8864, 106.9057),
        ("Astana", "Kazakhstan", 51.1694, 71.4491),
        ("Tashkent", "Uzbekistan", 41.2995, 69.2401),
        ("Bishkek", "Kyrgyzstan", 42.8746, 74.5698),
        ("Dushanbe", "Tajikistan", 38.5598, 68.7738),
        ("Ashgabat", "Turkmenistan", 37.9601, 58.3261),
        ("Tehran", "Iran", 35.6892, 51.3890),
        ("Baghdad", "Iraq", 33.3152, 44.3661),
        ("Damascus", "Syria", 33.5138, 36.2765),
        ("Beirut", "Lebanon", 33.8886, 35.4955),
        ("Amman", "Jordan", 31.9454, 35.9284),
        ("Jerusalem", "Israel", 31.7683, 35.2137),
        ("Sanaa", "Yemen", 15.5527, 44.2075),
        ("Muscat", "Oman", 23.5880, 58.3829),
        ("Doha", "Qatar", 25.2854, 51.5310),
        ("Manama", "Bahrain", 26.2285, 50.5860),
        ("Kuwait City", "Kuwait", 29.3759, 47.9774),
        ("Ankara", "Turkey", 39.9334, 32.8597),
        ("Tbilisi", "Georgia", 41.7151, 44.8271),
        ("Yerevan", "Armenia", 40.1792, 44.4991),
        ("Baku", "Azerbaijan", 40.4093, 49.8671),
        
        // Africa
        ("Cairo", "Egypt", 30.0444, 31.2357),
        ("Lagos", "Nigeria", 6.5244, 3.3792),
        ("Johannesburg", "South Africa", -26.2041, 28.0473),
        ("Nairobi", "Kenya", -1.2921, 36.8219),
        ("Casablanca", "Morocco", 33.5731, -7.5898),
        ("Algiers", "Algeria", 36.7538, 3.0588),
        ("Tunis", "Tunisia", 36.8065, 10.1815),
        ("Tripoli", "Libya", 32.8872, 13.1913),
        ("Khartoum", "Sudan", 15.5007, 32.5599),
        ("Addis Ababa", "Ethiopia", 9.0320, 38.7469),
        ("Dakar", "Senegal", 14.7167, -17.4677),
        ("Accra", "Ghana", 5.6037, -0.1870),
        ("Abidjan", "Ivory Coast", 5.3600, -4.0083),
        ("Abuja", "Nigeria", 9.0765, 7.3986),
        ("Kinshasa", "DR Congo", -4.4419, 15.2663),
        ("Luanda", "Angola", -8.8383, 13.2344),
        ("Maputo", "Mozambique", -25.9655, 32.5832),
        ("Harare", "Zimbabwe", -17.8252, 31.0335),
        ("Lusaka", "Zambia", -15.3875, 28.3228),
        ("Dar es Salaam", "Tanzania", -6.7924, 39.2083),
        ("Kampala", "Uganda", 0.3476, 32.5825),
        ("Kigali", "Rwanda", -1.9536, 30.0606),
        ("Bujumbura", "Burundi", -3.3614, 29.3599),
        ("Antananarivo", "Madagascar", -18.8792, 47.5079),
        ("Pretoria", "South Africa", -25.7479, 28.2293),
        ("Windhoek", "Namibia", -22.5609, 17.0658),
        ("Gaborone", "Botswana", -24.6282, 25.9231),
        ("Maseru", "Lesotho", -29.3167, 27.4833),
        ("Mbabane", "Eswatini", -26.3054, 31.1367),
        ("Lilongwe", "Malawi", -13.9626, 33.7741),
        
        // Oceania
        ("Sydney", "Australia", -33.8688, 151.2093),
        ("Melbourne", "Australia", -37.8136, 144.9631),
        ("Auckland", "New Zealand", -36.8485, 174.7633),
        ("Wellington", "New Zealand", -41.2865, 174.7762),
        ("Canberra", "Australia", -35.2809, 149.1300),
        ("Brisbane", "Australia", -27.4705, 153.0260),
        ("Perth", "Australia", -31.9505, 115.8605),
        ("Suva", "Fiji", -18.1248, 178.4501),
        ("Port Moresby", "Papua New Guinea", -9.4438, 147.1803),
        ("Honiara", "Solomon Islands", -9.4280, 159.9496),
        ("Port Vila", "Vanuatu", -17.7333, 168.3273),
        ("Noumea", "New Caledonia", -22.2758, 166.4580),
        ("Papeete", "French Polynesia", -17.5516, -149.5585),
        ("Apia", "Samoa", -13.8333, -171.7667)
    ]
    
    /// Get today's vibe check data - consistent for all users on the same day
    static func getTodayVibes() -> [CityVibe] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        // Use today's date as seed for consistent random generation
        let daysSince1970 = Int(today.timeIntervalSince1970 / 86400)
        var generator = SeededRandomGenerator(seed: UInt64(daysSince1970))
        
        // Get shuffled deck for today
        var shuffledCards = TarotDeck.allCards
        shuffledCards.shuffle(using: &generator)
        
        // Assign cards to cities
        var vibes: [CityVibe] = []
        for (index, city) in worldCities.enumerated() {
            let card = shuffledCards[index % shuffledCards.count]
            let percentage = Int.random(in: 60...95, using: &generator)
            
            vibes.append(CityVibe(
                cityName: city.0,
                countryName: city.1,
                latitude: city.2,
                longitude: city.3,
                card: card,
                percentage: percentage
            ))
        }
        
        return vibes
    }
    
    /// Get formatted date string for display
    static func getTodayDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: Date())
    }
}
