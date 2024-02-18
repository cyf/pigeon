import { Injectable } from '@nestjs/common'
import { IsDel, type LinkType, Prisma } from '@prisma/client'
import { CreateSocialDto } from './dto/create-social.dto'
import { UpdateSocialDto } from './dto/update-social.dto'
import { PrismaService } from '../prisma'

@Injectable()
export class SocialService {
  constructor(private readonly prismaService: PrismaService) {}

  async create(createSocialDto: CreateSocialDto, createBy: string) {
    const {
      title,
      subtitles = [],
      tips = [],
      descriptions = [],
    } = createSocialDto

    return this.prismaService.social.create({
      data: {
        title,
        subtitles: {
          create: subtitles.map(
            ({ title, color }: { title: string; color?: string }) => ({
              title,
              color,
              create_by: createBy,
              update_by: createBy,
            }),
          ),
        },
        tips: {
          create: tips.map(
            ({
              type,
              text,
              href,
              color,
            }: {
              type: LinkType
              text?: string
              href?: string
              color?: string
            }) => ({
              type,
              text,
              href,
              color,
              create_by: createBy,
              update_by: createBy,
            }),
          ),
        },
        descriptions: {
          create: descriptions.map(
            ({
              name,
              links,
            }: {
              name?: string
              links: Array<{
                type: LinkType
                text?: string
                href?: string
                color?: string
              }>
            }) => ({
              name,
              links: {
                create: links.map(
                  ({
                    type,
                    text,
                    href,
                    color,
                  }: {
                    type: LinkType
                    text?: string
                    href?: string
                    color?: string
                  }) => ({
                    type,
                    text,
                    href,
                    color,
                    create_by: createBy,
                    update_by: createBy,
                  }),
                ),
              },
              create_by: createBy,
              update_by: createBy,
            }),
          ),
        },
        create_by: createBy,
        update_by: createBy,
      },
      include: {
        subtitles: true,
        tips: true,
        descriptions: {
          include: {
            links: true,
          },
        },
      },
    })
  }

  async findAll(pageParam: number, pageSizeParam: number) {
    const page = pageParam || 1
    const pageSize = pageSizeParam || 10

    const where: Prisma.SocialWhereInput = {
      is_del: IsDel.NO,
    }
    const [socials, total] = await this.prismaService.$transaction([
      this.prismaService.social.findMany({
        skip: (page - 1) * pageSize,
        take: pageSize,
        select: {
          id: true,
          title: true,
          subtitles: {
            select: {
              id: true,
              title: true,
              color: true,
              social_id: true,
              create_by: true,
              create_date: true,
              update_by: true,
              update_date: true,
            },
            where: {
              is_del: IsDel.NO,
            },
          },
          tips: {
            select: {
              id: true,
              type: true,
              text: true,
              href: true,
              color: true,
              social_id: true,
              create_by: true,
              create_date: true,
              update_by: true,
              update_date: true,
            },
            where: {
              is_del: IsDel.NO,
            },
          },
          descriptions: {
            select: {
              id: true,
              name: true,
              links: {
                select: {
                  id: true,
                  type: true,
                  text: true,
                  href: true,
                  color: true,
                  description_id: true,
                  create_by: true,
                  create_date: true,
                  update_by: true,
                  update_date: true,
                },
                where: {
                  is_del: IsDel.NO,
                },
              },
              create_by: true,
              create_date: true,
              update_by: true,
              update_date: true,
            },
            where: {
              is_del: IsDel.NO,
            },
          },
          create_by: true,
          create_date: true,
          update_by: true,
          update_date: true,
        },
        where,
      }),
      this.prismaService.social.count({
        where,
      }),
    ])

    return {
      items: socials,
      page,
      pageSize,
      pageInfo: {
        total,
        pages: Math.ceil(total / pageSize),
      },
    }
  }

  async findOne(id: string) {
    return this.prismaService.social.findUnique({
      select: {
        id: true,
        title: true,
        subtitles: {
          select: {
            id: true,
            title: true,
            color: true,
            social_id: true,
            create_by: true,
            create_date: true,
            update_by: true,
            update_date: true,
          },
          where: {
            is_del: IsDel.NO,
          },
        },
        tips: {
          select: {
            id: true,
            type: true,
            text: true,
            href: true,
            color: true,
            social_id: true,
            create_by: true,
            create_date: true,
            update_by: true,
            update_date: true,
          },
          where: {
            is_del: IsDel.NO,
          },
        },
        descriptions: {
          select: {
            id: true,
            name: true,
            links: {
              select: {
                id: true,
                type: true,
                text: true,
                href: true,
                color: true,
                description_id: true,
                create_by: true,
                create_date: true,
                update_by: true,
                update_date: true,
              },
              where: {
                is_del: IsDel.NO,
              },
            },
            create_by: true,
            create_date: true,
            update_by: true,
            update_date: true,
          },
          where: {
            is_del: IsDel.NO,
          },
        },
        create_by: true,
        create_date: true,
        update_by: true,
        update_date: true,
      },
      where: {
        id,
        is_del: IsDel.NO,
      },
    })
  }

  async update(
    id: string,
    delSubtitleIds: string[],
    delTipIds: string[],
    delDescIds: string[],
    delLinkIds: string[],
    updateSocialDto: UpdateSocialDto,
    updateBy: string,
  ) {
    const {
      title,
      subtitles = [],
      tips = [],
      descriptions = [],
    } = updateSocialDto
    return this.prismaService.social.update({
      data: {
        title,
        subtitles: {
          updateMany: [
            ...(delSubtitleIds.length
              ? [
                  {
                    data: {
                      update_by: updateBy,
                      is_del: IsDel.YES,
                    },
                    where: {
                      id: {
                        in: delSubtitleIds,
                      },
                      is_del: IsDel.NO,
                    },
                  },
                ]
              : []),
            ...(subtitles
              .filter(
                (subtitle: { id?: string; title: string; color?: string }) =>
                  !!subtitle.id,
              )
              .map(({ id, title, color }) => ({
                data: {
                  title,
                  color,
                  update_by: updateBy,
                },
                where: {
                  id,
                  is_del: IsDel.NO,
                },
              })) || []),
          ],
          create: subtitles
            .filter(
              (subtitle: { id?: string; title: string; color?: string }) =>
                !subtitle.id,
            )
            .map(({ title, color }) => ({
              title,
              color,
              create_by: updateBy,
              update_by: updateBy,
            })),
        },
        tips: {
          updateMany: [
            ...(delTipIds.length
              ? [
                  {
                    data: {
                      update_by: updateBy,
                      is_del: IsDel.YES,
                    },
                    where: {
                      id: {
                        in: delTipIds,
                      },
                      is_del: IsDel.NO,
                    },
                  },
                ]
              : []),
            ...(tips
              .filter(
                (tip: {
                  id?: string
                  type: LinkType
                  text?: string
                  href?: string
                  color?: string
                }) => !!tip.id,
              )
              .map(({ id, type, text, href, color }) => ({
                data: {
                  type,
                  text,
                  href,
                  color,
                  update_by: updateBy,
                },
                where: {
                  id,
                  is_del: IsDel.NO,
                },
              })) || []),
          ],
          create: tips
            .filter(
              (tip: {
                id?: string
                type: LinkType
                text?: string
                href?: string
                color?: string
              }) => !tip.id,
            )
            .map(({ type, text, href, color }) => ({
              type,
              text,
              href,
              color,
              create_by: updateBy,
              update_by: updateBy,
            })),
        },
        descriptions: {
          updateMany: [
            ...(delDescIds.length
              ? [
                  {
                    data: {
                      update_by: updateBy,
                      is_del: IsDel.YES,
                    },
                    where: {
                      id: {
                        in: delDescIds,
                      },
                      is_del: IsDel.NO,
                    },
                  },
                ]
              : []),
            ...(descriptions
              .filter(
                (description: {
                  id?: string
                  name?: string
                  links: Array<{
                    id?: string
                    type: LinkType
                    text?: string
                    href?: string
                    color?: string
                  }>
                }) => !!description.id,
              )
              .map(({ id, name, links }) => ({
                data: {
                  name,
                  links: {
                    updateMany: [
                      ...(delLinkIds.length
                        ? [
                            {
                              data: {
                                update_by: updateBy,
                                is_del: IsDel.YES,
                              },
                              where: {
                                id: {
                                  in: delLinkIds,
                                },
                                is_del: IsDel.NO,
                              },
                            },
                          ]
                        : []),
                      ...(links
                        .filter(
                          (link: {
                            id?: string
                            type: LinkType
                            text?: string
                            href?: string
                            color?: string
                          }) => !!link.id,
                        )
                        .map(({ id, type, text, href, color }) => ({
                          data: {
                            type,
                            text,
                            href,
                            color,
                            update_by: updateBy,
                          },
                          where: {
                            id,
                            is_del: IsDel.NO,
                          },
                        })) || []),
                    ],
                    createMany: {
                      data: links
                        .filter(
                          (link: {
                            id?: string
                            type: LinkType
                            text?: string
                            href?: string
                            color?: string
                          }) => !link.id,
                        )
                        .map(({ type, text, href, color }) => ({
                          type,
                          text,
                          href,
                          color,
                          create_by: updateBy,
                          update_by: updateBy,
                        })),
                    },
                  },
                  update_by: updateBy,
                },
                where: {
                  id,
                  is_del: IsDel.NO,
                },
              })) || []),
          ],
          create: descriptions
            .filter((description: any) => !description.id)
            .map(
              ({
                name,
                links,
              }: {
                name?: string
                links: Array<{
                  type: LinkType
                  text?: string
                  href?: string
                  color?: string
                }>
              }) => ({
                name,
                links: {
                  // updateMany: {
                  //   data: {
                  //     update_by: updateBy,
                  //     update_date: new Date(),
                  //     is_del: "YES",
                  //   },
                  //   where: {
                  //     id: {
                  //       notIn: links
                  //         .filter((link: any) => !!link.id)
                  //         .map((link: any) => link.id),
                  //     },
                  //     is_del: "NO",
                  //   },
                  // },
                  createMany: {
                    data: links
                      .filter(
                        (link: {
                          id?: string
                          type: LinkType
                          text?: string
                          href?: string
                          color?: string
                        }) => !link.id,
                      )
                      .map(({ type, text, href, color }) => ({
                        type,
                        text,
                        href,
                        color,
                        create_by: updateBy,
                        update_by: updateBy,
                      })),
                  },
                },
                create_by: updateBy,
                update_by: updateBy,
              }),
            ),
        },
        update_by: updateBy,
      },
      include: {
        subtitles: true,
        tips: true,
        descriptions: {
          include: {
            links: true,
          },
        },
      },
      where: {
        id,
        is_del: IsDel.NO,
      },
    })
  }

  async remove(id: string, updateBy: string) {
    return this.prismaService.social.update({
      data: {
        update_by: updateBy,
        is_del: IsDel.YES,
      },
      where: {
        id,
        is_del: IsDel.NO,
      },
    })
  }
}
