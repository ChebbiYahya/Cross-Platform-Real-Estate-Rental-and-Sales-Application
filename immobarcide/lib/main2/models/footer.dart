class Footer {
  String title;
  List<String> parametres;
  Footer({
    required this.title,
    required this.parametres,
  });
}

List<Footer> footer = [
  Footer(
    title: "Company",
    parametres: [
      "About",
      "Press",
      "Blog",
      "Careers",
      "Security",
      "Drive Center",
    ],
  ),
  Footer(
    title: "Information",
    parametres: [
      "Our Story",
      "Recipes",
      "Nutrition",
      "Resources",
      "Newsletter",
      "Contact",
    ],
  ),
  Footer(
    title: "Services",
    parametres: [
      "Customer service",
      "Recommend a restaurant",
      "Signup a restaurant",
      "Jobs",
      "Press",
      "Terms of Use",
    ],
  ),
];
