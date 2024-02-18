import { Injectable } from '@nestjs/common'
import { IsDel, Prisma } from '@prisma/client'
import { CreateEmojiDto } from './dto/create-emoji.dto'
import { UpdateEmojiDto } from './dto/update-emoji.dto'
import { PrismaService } from '../prisma'

@Injectable()
export class EmojiService {
  constructor(private readonly prismaService: PrismaService) {}

  async create(createEmojiDto: CreateEmojiDto, createBy: string) {
    const { image, type, size, text, color } = createEmojiDto
    return this.prismaService.emoji.create({
      data: {
        image,
        type,
        size,
        text,
        color,
        create_by: createBy,
        update_by: createBy,
      },
    })
  }

  async createAll(createEmojiDtoList: CreateEmojiDto[], createBy: string) {
    return this.prismaService.emoji.createMany({
      data: createEmojiDtoList.map(({ image, type, size, text, color }) => ({
        image,
        type,
        size,
        text,
        color,
        create_by: createBy,
        update_by: createBy,
      })),
    })
  }

  async findAll(pageParam: number, pageSizeParam: number) {
    const page = pageParam || 1
    const pageSize = pageSizeParam || 10

    const where: Prisma.EmojiWhereInput = {
      is_del: IsDel.NO,
    }
    const [emojis, total] = await this.prismaService.$transaction([
      this.prismaService.emoji.findMany({
        skip: (page - 1) * pageSize,
        take: pageSize,
        select: {
          id: true,
          image: true,
          type: true,
          size: true,
          text: true,
          color: true,
          create_by: true,
          create_date: true,
          update_by: true,
          update_date: true,
        },
        where,
      }),
      this.prismaService.emoji.count({
        where,
      }),
    ])

    return {
      items: emojis,
      page,
      pageSize,
      pageInfo: {
        total,
        pages: Math.ceil(total / pageSize),
      },
    }
  }

  async findOne(id: string) {
    return this.prismaService.emoji.findUnique({
      select: {
        id: true,
        image: true,
        type: true,
        size: true,
        text: true,
        color: true,
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

  async update(id: string, updateEmojiDto: UpdateEmojiDto, updateBy: string) {
    const { image, type, size, text, color } = updateEmojiDto
    return this.prismaService.emoji.update({
      data: {
        image,
        type,
        size,
        text,
        color,
        update_by: updateBy,
      },
      where: {
        id,
        is_del: IsDel.NO,
      },
    })
  }

  async remove(id: string, updateBy: string) {
    return this.prismaService.emoji.update({
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
