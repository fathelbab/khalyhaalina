class TravelBean {
  String name;
  String location;
  String url;

  TravelBean(this.name, this.location, this.url);

  static List<TravelBean> generateTravelBean() {
    return [
      TravelBean("Peach", "Spain ES1", "assets/images/app_logo.png"),
      TravelBean("Grassland", "Spain ES2", "assets/images/app_logo.png"),
      TravelBean("Starry sky", "Spain ES3", "assets/images/app_logo.png"),
      TravelBean("Beauty Pic", "Spain ES4", "assets/images/app_logo.png"),
    ];
  }

  static List<TravelBean> generateMostPopularBean() {
    return [
      TravelBean("Peach", "Spain ES", "assets/images/app_logo.png"),
      TravelBean("Grassland", "Spain ES", "assets/images/app_logo.png"),
      TravelBean("Starry sky", "Spain ES", "assets/images/app_logo.png"),
      TravelBean("Beauty Pic", "Spain ES", "assets/images/app_logo.png"),
    ];
  }
}
