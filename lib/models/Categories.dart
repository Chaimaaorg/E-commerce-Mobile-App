class Categories {
  String category;
  List<String> subCategories;

  Categories({
    required this.category,
    required this.subCategories,
  });

  static List<String> getSubCategories(String category) {
    Categories? selectedCategory = categoriesList.firstWhere(
      (element) => element.category == category,
    );

    return selectedCategory?.subCategories ?? [];
  }
  static List<String> getAllCategories() {
    return categoriesList.map((category) => category.category).toList();
  }
  static final List<Categories> categoriesList = [
    Categories(
      category: "A/V distributor",
      subCategories: [
        "A/V Matrix",
        "Splitter / distributor",
        "Switch",
        "Extender",
        "Control system",
        "Video converter/Adaptors",
      ],
    ),
    Categories(
      category: "Video projection",
      subCategories: [
        "Projectors",
        "Projection screens",
        "Projector mounts",
        "Wireless projection system",
        "Documents viewers",
        "3D glasses",
      ],
    ),
    Categories(
      category: "Interactive display",
      subCategories: [
        "Interactive screens",
        "Interactive whiteboards",
      ],
    ),
    Categories(
      category: "Streaming",
      subCategories: [
        "Capture and streaming systems",
        "A/V mixers",
      ],
    ),
    Categories(
      category: "KVM",
      subCategories: [
        "KVM Switch",
        "KVM Cables",
        "KVM Extender",
        "KVM Accessories",
      ],
    ),
    Categories(
      category: "Video conference",
      subCategories: [
        "Pro Webcams",
        "Video Conference Cameras",
        "Camera mounts",
      ],
    ),
    Categories(
      category: "Sonorisation",
      subCategories: [
        "Speakers",
        "Mixers",
        "Wired microphones",
        "Wireless microphones",
        "Mixers/Amplifiers",
        "Sono Accessories",
      ],
    ),
    Categories(
      category: "Audio Conferencing",
      subCategories: [
        "Wired conferencing system",
        "Wireless conferencing system",
        "Multimedia conferencing system",
      ],
    ),
    Categories(
      category: "Video surveillance",
      subCategories: [
        "Switch",
        "Hard disk",
        "Analog camera",
        "IP Camera",
        "NVR",
      ],
    ),
    Categories(
      category: "Cable distribution",
      subCategories: [
        "Power",
        "Transmodulator / Modulator",
        "Antennas /LNB",
        "Preamp / Amplifiers",
        "Diversion / Dispatchers",
        "Multi-switch",
        "TV Cables",
      ],
    ),
    Categories(
      category: "Gaming",
      subCategories: [
        "Mouses",
        "Mouses pad",
        "Keyboard",
        "Monitor",
        "Headphones",
      ],
    ),
    Categories(
      category: "Pre-cabling & IT",
      subCategories: [
        "Computer pre-cabling",
        "Power inverter",
      ],
    ),
    Categories(
      category: "Accessories",
      subCategories: [
        "Headphones",
        "Multi-port receiving stations",
        "Video cables",
        "Audio cables",
        "Floor box",
        "Speakers cables",
        "Connectors / Sockets",
        "Mounts",
      ],
    ),
  ];
}
