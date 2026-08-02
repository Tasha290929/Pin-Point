import 'package:pin_point/features/map/data/models/model_location.dart';

class MockLocations {
  static final List<ModelLocation> all = [
    ModelLocation(
      id: '1',
      name: 'Andy\'s Restaurant',
      category: 'food',
      latitude: 47.02671258107101,
      longitude: 28.837308880955575,
      fullAddress: 'Strada Pușkin 32, MD-2012, Chișinău, Молдова',
      rating: 5,
      description:
      'Andy\'s (cunoscut și ca Andy\'s Pizza) este cea mai populară și extinsă rețea de restaurante de tip causal-dining și fast-casual din Republica Moldova, fondată în Chișinău.',
      mainImage:
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRk6nyR86or4J8NErHIEzsRRKcwbKneoFIKPECNyKVYTYOjkpL3O9D1giE&s=10',
      iconAsset: 'andis_logo.svg',
      workingHours: '24/7',
      phoneNumber: '022210210',
    ),
    ModelLocation(
      id: '2',
      name: 'AlcoMarket',
      category: 'shop',
      latitude: 47.0290912,
      longitude: 28.8347961,
      fullAddress: 'Chișinău MD, Strada Alexandru cel Bun 108, MD-2005, Молдова',
      rating: 4.3,
      description:
      'AlcoMarket este un magazin specializat în comercializarea băuturilor alcoolice, oferind o gamă variată de vinuri, spirtoase și bere din Moldova și din import.',
      mainImage: 'https://lh3.googleusercontent.com/gps-cs-s/AHRPTWnbT7vmrh61sUyV1ZWYpNAi6coPRimAIH393c40RcGlUGUGcw39SOW9633SxU6Uv_siyIyQWrIO3Y6YdYexzgEjDAAJn61CwLhHAyLK0umN3gK9M9klQRrg54wkoWonCiy4YWOv=w408-h306-k-no',
      iconAsset: 'alcomarket_logo.svg',
      workingHours: '09:00 - 22:00',
    ),
    ModelLocation(
      id: '3',
      name: 'Shopping MallDova',
      category: 'mall',
      latitude: 47.0046143,
      longitude: 28.8407153,
      fullAddress: 'Strada Arborilor 21Republica Moldova Chișinău MD, MD-2025, Молдова',
      rating: 4.4,
      description:
      'MallDova este unul dintre cele mai mari centre comerciale din Chișinău, oferind magazine de retail, divertisment și o zonă food-court.',
      mainImage: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRVfHKuu658XBkSgGIQyeRyqpD-qVXM9ejTtGA3e7hnFg&s=10',
      imageUrls: [
        'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0d/4c/38/de/photo2jpg.jpg?w=1200&h=-1&s=1',
        'https://shoppingmalldova.md/wp-content/uploads/2026/07/1920x1080-news-web-ro.jpg',
        'https://shoppingmalldova.md/wp-content/uploads/2026/06/image-14-1536x864.jpeg',
      ],
      iconAsset: 'mall_logo.svg',
      workingHours: '09:00 - 22:00',
    ),
    ModelLocation(
      id: '4',
      name: 'Maib Park',
      category: 'park',
      latitude: 47.02509,
      longitude: 28.8254486,
      fullAddress: 'Oficiul central, Chișinau MD, 31 August 1989 St 127, MD-2012, Молдова',
      rating: 4.6,
      description:
      'Maib Park este un spațiu urban amenajat, popular printre locuitorii orașului pentru plimbări și activități în aer liber.',
      mainImage: '',
      iconAsset: 'maib_logo.svg',
      workingHours: '24/7',
    ),
    ModelLocation(
      id: '5',
      name: 'Parcul "Cuza Vodă"',
      category: 'park',
      latitude: 46.9884428,
      longitude: 28.8686109,
      fullAddress: 'Strada Cuza Vodă 5, Chișinău, Молдова',
      rating: 4.5,
      description:
      'Parcul "Cuza Vodă" este o zonă verde din Chișinău, apreciată pentru aleile umbrite și atmosfera liniștită, potrivită pentru plimbări și relaxare.',
      mainImage: 'https://lh3.googleusercontent.com/gps-cs-s/AHRPTWkTs6oPhKOoOUBQyqOnckwqqyXOX4dEuzk-0i0betupiBQ9idL5dB7UIomUN8EJ1xq4Ki8SRqpWLFoUuaUkclvZHDdVF5D-92_Xg0i_rWTfdY5teGmFTIux0thmG6LX-gwOEQ9r=w408-h306-k-no',
      iconAsset: 'park_logo.svg',
      workingHours: '24/7',
    ),

    ModelLocation(
      id: '6',
      name: 'Dulcinella',
      category: 'food',
      latitude: 47.0420025,
      longitude: 28.7614826,
      fullAddress: 'Strada Alba Iulia 103, Chișinău, Молдова',
      rating: 4.7,
      description:
      'Dulcinella este o cofetărie-cafenea din Chișinău, cunoscută pentru prăjituri, deserturi și băuturi calde într-o atmosferă primitoare.',
      mainImage: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQIygFtfBK1oo08yYWqnTDwxFKQy3MTziQ7-5qJj_-nQ&s=10',
      iconAsset: 'cafe_logo.svg',
      workingHours: '09:00 - 21:00',
    ),
  ];
}