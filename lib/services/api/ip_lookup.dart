import 'package:http/http.dart' as http;
import 'dart:convert';


Future<String> getUserLocation() async {
  try {
    final response = await http.get(Uri.parse('http://ip-api.com/json'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final String country = jsonData['country'];
      final String region = jsonData['regionName'];
      final String city = jsonData['city'];

      final String location = '$city, $region, $country';
      return location;
    } else {
      // Handle the case when the API request fails
      return 'Location not available';
    }
  } catch (e) {
    // Handle any errors that occur during the HTTP request
    return 'Location not available';
  }
}
