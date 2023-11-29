import 'package:flutter/material.dart';
import 'package:homing_pigeon/modules/detail/detail.dart';

final List<CardItem> cards = [
  CardItem(
    title: 'YouTube',
    subtitle: '搜"陈一发儿"',
    descriptions: [
      Description(
        name: '一般周六唱歌｜聊天｜读邮件；周三打游戏～',
        links: [
          Link(
            type: LinkType.link,
            uri: Uri.parse('https://www.youtube.com/@chenyifaer'),
          ),
        ],
      ),
    ],
  ),
  CardItem(
    title: 'Twitch',
    subtitle: '搜"thebs_chen"',
    descriptions: [
      Description(
        name: '一般随机时间看电影～',
        links: [
          Link(
            type: LinkType.link,
            uri: Uri.parse('https://www.twitch.tv/thebs_chen'),
          ),
        ],
      ),
    ],
  ),
  CardItem(
    title: '投稿邮箱',
    subtitle: '长期征稿中! 情感咨询、人生迷思、买房卖房、生理卫生、投资理财、小学以下算术...等问题均可投稿。排忧解惑，治病救人～～',
    descriptions: [
      Description(
        links: [
          Link(
            type: LinkType.link,
            uri: Uri.parse('mailto://chenyifaer777@gmail.com'),
          ),
        ],
      ),
    ],
  ),
  CardItem(
    title: '微博话题',
    subtitle: '搜"陈一发儿"',
    descriptions: [
      Description(
        name: '水友们的精神家园',
        links: [
          Link(
            type: LinkType.link,
            uri: Uri.parse(
              'https://weibo.com/p/100808b68aba47f332d118ad655dcfa1029afc',
            ),
          ),
        ],
      ),
    ],
  ),
  CardItem(
    title: '官方淘宝店',
    subtitle: '搜"喜瑞斯"',
    descriptions: [
      Description(
        links: [
          Link(
            type: LinkType.link,
            uri: Uri.parse('https://chenyifaer.taobao.com'),
          ),
        ],
      ),
    ],
  ),
  CardItem(
    title: 'Spotify',
    subtitle: '搜"陈一发儿"',
    descriptions: [
      Description(
        links: [
          Link(
            type: LinkType.link,
            uri: Uri.parse(
              'https://open.spotify.com/artist/10xtjTRMlKZ7aFx6VBQlSj',
            ),
          ),
        ],
      ),
    ],
  ),
  CardItem(
    title: 'Instagram',
    subtitle: '搜"yifaer_chen"',
    descriptions: [
      Description(
        links: [
          Link(
            type: LinkType.link,
            uri: Uri.parse('https://www.instagram.com/yifaer_chen'),
          ),
        ],
      ),
    ],
  ),
  CardItem(
    title: '开播提醒群',
    descriptions: [
      Description(
        name: 'TG（Telegram）开播通知群',
        links: [
          Link(
            type: LinkType.link,
            uri: Uri.parse('https://t.me/FaFa67373'),
          ),
          const Link(
            type: LinkType.text,
            text: 'FaFa67373',
          ),
        ],
      ),
      const Description(
        name: 'QQ开播通知群',
        links: [
          Link(
            type: LinkType.text,
            text: '320522657',
          ),
        ],
      ),
    ],
  ),
];

class SocialView extends StatelessWidget {
  const SocialView({super.key});

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      appBar: AppBar(
        title: const Text('社交'),
      ),
      body: ListView.separated(
        itemCount: cards.length,
        padding: EdgeInsets.only(top: 14, bottom: bottom),
        itemBuilder: (BuildContext context, int index) =>
            SocialCard(item: cards[index]),
        separatorBuilder: (BuildContext context, int index) =>
        const Divider(height: 14),
      ),
    );
  }
}
