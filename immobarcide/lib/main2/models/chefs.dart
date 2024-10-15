class Chef {
  String image;
  String name;
  String designation;
  int index;
  Chef({
    required this.image,
    required this.name,
    required this.designation,
    required this.index,
  });
}

List<Chef> chefs = [
  Chef(
    image: "https://picsum.photos/250?image=9",
    name: "Chao Xi Zao",
    designation: "Head Chef",
    index: 1,
  ),
  Chef(
    image: "https://picsum.photos/250?image=9",
    name: "Chao Xi Zao1",
    designation: "Head Chef2",
    index: 2,
  ),
  Chef(
    image: "https://picsum.photos/250?image=9",
    name: "Chao Xi Zao",
    designation: "Head Chef3",
    index: 3,
  ),
  Chef(
    image: "https://picsum.photos/250?image=9",
    name: "Chao Xi Zao",
    designation: "Head Chef4",
    index: 4,
  ),
];
