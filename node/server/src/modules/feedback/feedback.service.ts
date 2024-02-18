import { Injectable } from '@nestjs/common'
import { IsDel, Prisma } from '@prisma/client'
import { CreateFeedbackDto } from './dto/create-feedback.dto'
import { UpdateFeedbackDto } from './dto/update-feedback.dto'
import { PrismaService } from '../prisma'

@Injectable()
export class FeedbackService {
  constructor(private readonly prismaService: PrismaService) {}

  async create(createFeedbackDto: CreateFeedbackDto, createBy: string) {
    const { title, description, files = [] } = createFeedbackDto
    return this.prismaService.feedback.create({
      data: {
        title,
        description,
        files: {
          create: files.map(
            ({
              url,
              type,
              size,
              title,
            }: {
              url: string
              type?: string
              size?: number
              title?: string
            }) => ({
              url,
              type,
              size,
              title,
              create_by: createBy,
              update_by: createBy,
            }),
          ),
        },
        create_by: createBy,
        update_by: createBy,
      },
      include: {
        files: true,
      },
    })
  }

  async findAll(pageParam: number, pageSizeParam: number) {
    const page = pageParam || 1
    const pageSize = pageSizeParam || 10

    const where: Prisma.FeedbackWhereInput = {
      is_del: 'NO',
    }
    const [feedbacks, total] = await this.prismaService.$transaction([
      this.prismaService.feedback.findMany({
        skip: (page - 1) * pageSize,
        take: pageSize,
        select: {
          id: true,
          title: true,
          description: true,
          files: {
            select: {
              id: true,
              feedback_id: true,
              url: true,
              type: true,
              size: true,
              title: true,
              create_by: true,
              create_date: true,
              update_by: true,
              update_date: true,
            },
            where: {
              is_del: 'NO',
            },
          },
          create_by: true,
          create_date: true,
          update_by: true,
          update_date: true,
        },
        where,
      }),
      this.prismaService.feedback.count({
        where,
      }),
    ])

    return {
      items: feedbacks,
      page,
      pageSize,
      pageInfo: {
        total,
        pages: Math.ceil(total / pageSize),
      },
    }
  }

  async findOne(id: string) {
    return this.prismaService.feedback.findUnique({
      select: {
        id: true,
        title: true,
        description: true,
        files: {
          select: {
            id: true,
            feedback_id: true,
            url: true,
            type: true,
            size: true,
            title: true,
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
    delFileIds: string[],
    updateFeedbackDto: UpdateFeedbackDto,
    updateBy: string,
  ) {
    const { title, description, files = [] } = updateFeedbackDto
    return this.prismaService.feedback.update({
      data: {
        title,
        description,
        files: {
          updateMany: [
            ...(delFileIds.length
              ? [
                  {
                    data: {
                      update_by: updateBy,
                      is_del: IsDel.YES,
                    },
                    where: {
                      id: {
                        in: delFileIds,
                      },
                      is_del: IsDel.NO,
                    },
                  },
                ]
              : []),
            ...(files
              .filter((file: any) => !!file.id)
              .map(
                ({
                  id,
                  url,
                  type,
                  size,
                  title,
                }: {
                  id: string
                  url: string
                  type: string
                  size: number
                  title: string
                }) => ({
                  data: {
                    url,
                    type,
                    size,
                    title,
                    update_by: updateBy,
                  },
                  where: {
                    id,
                    is_del: IsDel.NO,
                  },
                }),
              ) || []),
          ],
          create: files
            .filter((file: any) => !file.id)
            .map(
              ({
                url,
                type,
                size,
                title,
              }: {
                url: string
                type: string
                size: number
                title: string
              }) => ({
                url,
                type,
                size,
                title,
                create_by: updateBy,
                update_by: updateBy,
              }),
            ),
        },
        update_by: updateBy,
      },
      include: {
        files: true,
      },
      where: {
        id,
        is_del: IsDel.NO,
      },
    })
  }

  async remove(id: string, updateBy: string) {
    return this.prismaService.feedback.update({
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
