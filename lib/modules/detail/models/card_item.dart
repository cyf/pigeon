class CardItem {
  const CardItem({
    required this.title,
    this.subtitles,
    this.tips,
    this.descriptions,
  });

  final String title;
  final List<SubTitle>? subtitles;
  final List<Tip>? tips;
  final List<Description>? descriptions;
}

class SubTitle {
  const SubTitle({
    required this.title,
    this.color,
  });

  final String title;
  final int? color;
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

class Tip {
  const Tip({
    required this.type,
    required this.text,
    this.uri,
    this.color,
  }) : assert(
          type == LinkType.link ? uri != null : true,
          'When type is link, uri is not allowed to be null.',
        );

  final LinkType type;
  final String text;
  final Uri? uri;
  final int? color;
}

class Link {
  const Link({
    required this.type,
    this.text,
    this.uri,
    this.color,
  })  : assert(
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
  final int? color;
}
