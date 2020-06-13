
class DayOneCountry {
  String country;
  String countryCode;
  String province;
  String city;
  String cityCode;
  String lat;
  String lon;
  int confirmed;
  int deaths;
  int recovered;
  int active;
  String date;

  DayOneCountry({ this.country, this.countryCode, this.province, this.city,
      this.cityCode, this.lat, this.lon, this.confirmed, this.deaths,
      this.recovered, this.active, this.date });

  static List<DayOneCountry> fromJson(List<dynamic> json){
    List<DayOneCountry> values = new List<DayOneCountry>();
    (json as List).toList().asMap().forEach((dynamic index, dynamic item) => {
      values.add(new DayOneCountry(
          country: item['Country'],
          countryCode: item['CountryCode'],
          province: item['Province'],
          city: item['City'],
          cityCode: item['CityCode'],
          lat: item['Lat'],
          lon: item['Lon'],
          confirmed: item['Confirmed'],
          deaths: item['Deaths'],
          recovered: item['Recovered'],
          active: item['Active'],
          date: item['Date']
      ))
    });
    return values;
  }
}