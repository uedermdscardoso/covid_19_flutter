
class Country {
  String country;
  String countryCode;
  String slug;
  int newConfirmed;
  int totalConfirmed;
  int newDeaths;
  int totalDeaths;
  int newRecovered;
  int totalRecovered;
  String date;

  Country({ this.country, this.countryCode, this.slug, this.newConfirmed,
      this.totalConfirmed, this.newDeaths, this.totalDeaths,
      this.newRecovered, this.totalRecovered, this.date });

}