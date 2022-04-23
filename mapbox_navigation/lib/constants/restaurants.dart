class Coordinates {
  final String latitude;
  final String longitude;

  const Coordinates({
    required this.latitude,
    required this.longitude,
  });
}

class Restaurant {
  final String id;
  final String name;
  final String items;
  final String image;
  final Coordinates coordinates;

  const Restaurant({
    required this.id,
    required this.name,
    required this.items,
    required this.image,
    required this.coordinates,
  });
}

const allRestaurant = [
  Restaurant(
    id: '0',
    name: 'Starbucks',
    items: 'Coffee, Espresso, Cold Brew, Desserts',
    image: 'https://api.time.com/wp-content/uploads/2016/04/starbucks.jpeg',
    coordinates: Coordinates(
      latitude: '37.3304673610577',
      longitude: '-122.02972194953225',
    ),
  ),
  Restaurant(
    id: '0',
    name: 'KFC',
    items: 'Buckets, Burgers, Biryani, Snacks, Beverages',
    image:
        'https://indiaeducationdiary.in/wp-content/uploads/2020/10/IMG-20201024-WA0014.jpg',
    coordinates: Coordinates(
      latitude: '37.333556739502136',
      longitude: '-122.02940574472692',
    ),
  ),
  Restaurant(
    id: '0',
    name: 'Domino\'s',
    items: 'Pizza, Sides, Beverages, Pasta, Chicken',
    image:
        'https://image.cnbcfm.com/api/v1/image/106334183-1578943648578gettyimages-526250086.jpeg?v=1578943742&w=1600&h=900',
    coordinates: Coordinates(
      latitude: '37.33146975596025',
      longitude: '-122.03456599939231',
    ),
  ),
  Restaurant(
    id: '0',
    name: 'Pizza Hut',
    items: 'Pizza, Sides, Drinks, Deserts',
    image:
        'https://10619-2.s.cdn12.com/rests/small/w550/h367/103_510330142.jpg',
    coordinates: Coordinates(
      latitude: '37.33219697177026',
      longitude: '-122.02848706089699',
    ),
  ),
];
