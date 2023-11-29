class CardItem {
  const CardItem({
    required this.title,
    this.subtitle,
    this.descriptions,
  });

  final String title;
  final String? subtitle;
  final List<Description>? descriptions;
}

class Description {
  const Description({required this.links, this.name});

  final String? name;
  final List<Link> links;
}

enum LinkType {
  link,
  text,
}

class Link {
  const Link({required this.type, this.text, this.uri})
      : assert(
          type == LinkType.link ? uri != null : true,
          'When type is link, uri is not allowed to be null.',
        ),
        assert(
          type == LinkType.text ? text != null : true,
          'When type is text, text is not allowed to be null.',
        );

  final LinkType type;
  final String? text;
  final Uri? uri;
}
