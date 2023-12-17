import 'dart:math';

double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const R = 6371.0; // Radius of the Earth in kilometers

  double toRadians(double degree) {
    return degree * pi / 180.0;
  }

  // Convert latitude and longitude from degrees to radians
  lat1 = toRadians(lat1);
  lon1 = toRadians(lon1);
  lat2 = toRadians(lat2);
  lon2 = toRadians(lon2);

  // Haversine formula
  double dlat = lat2 - lat1;
  double dlon = lon2 - lon1;
  double a = pow(sin(dlat / 2), 2) +
      cos(lat1) * cos(lat2) * pow(sin(dlon / 2), 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  // Calculate the distance
  double distance = R * c;

  return distance;
}

void main() {
  // Example usage
  double lat1 = 37.7749; // Example latitude for San Francisco
  double lon1 = -122.4194; // Example longitude for San Francisco
  double lat2 = 34.0522; // Example latitude for Los Angeles
  double lon2 = -118.2437; // Example longitude for Los Angeles

  double result = calculateDistance(lat1, lon1, lat2, lon2);
  print("Distance: ${result.toStringAsFixed(2)} km");
}
