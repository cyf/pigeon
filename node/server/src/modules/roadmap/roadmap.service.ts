import { Injectable } from '@nestjs/common'
import { IsDel } from '@prisma/client'
import { CreateRoadmapDto } from './dto/create-roadmap.dto'
import { UpdateRoadmapDto } from './dto/update-roadmap.dto'
import { PrismaService } from '../prisma'

@Injectable()
export class RoadmapService {
  constructor(private readonly prismaService: PrismaService) {}

  async create(createRoadmapDto: CreateRoadmapDto, createBy: string) {
    const {
      title,
      description,
      from,
      to,
      background,
      labels = [],
    } = createRoadmapDto
    return this.prismaService.roadmap.create({
      data: {
        title,
        description,
        from,
        to,
        background,
        labels: {
          create: labels.map(
            ({
              icon,
              text,
              order,
              color,
            }: {
              icon: string
              text: string
              order: number
              color: string
            }) => ({
              icon,
              text,
              order,
              color,
              create_by: createBy,
              update_by: createBy,
            }),
          ),
        },
        create_by: createBy,
        update_by: createBy,
      },
      include: {
        labels: true,
      },
    })
  }

  async findAll(yearParam: number, monthParam: number) {
    const currentDate = new Date()
    const year = yearParam || currentDate.getFullYear()
    const month = monthParam || currentDate.getMonth()
    const startDate = new Date(year, month, 1)
    const endDate = new Date(year, month + 1, 0)

    return this.prismaService.roadmap.findMany({
      select: {
        id: true,
        title: true,
        description: true,
        from: true,
        to: true,
        background: true,
        labels: {
          select: {
            id: true,
            roadmap_id: true,
            icon: true,
            text: true,
            order: true,
            color: true,
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
        NOT: {
          OR: [
            {
              to: {
                lte: startDate,
              },
            },
            {
              from: {
                gte: endDate,
              },
            },
          ],
        },
        AND: {
          is_del: IsDel.NO,
        },
      },
    })
  }

  async findOne(id: string) {
    return this.prismaService.roadmap.findUnique({
      select: {
        id: true,
        title: true,
        description: true,
        from: true,
        to: true,
        background: true,
        labels: {
          select: {
            id: true,
            roadmap_id: true,
            icon: true,
            text: true,
            order: true,
            color: true,
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
    delLabelIds: string[],
    updateRoadmapDto: UpdateRoadmapDto,
    updateBy: string,
  ) {
    const {
      title,
      description,
      from,
      to,
      background,
      labels = [],
    } = updateRoadmapDto

    return this.prismaService.roadmap.update({
      data: {
        title,
        description,
        from,
        to,
        background,
        labels: {
          updateMany: [
            ...(delLabelIds.length
              ? [
                  {
                    data: {
                      update_by: updateBy,
                      is_del: IsDel.YES,
                    },
                    where: {
                      id: {
                        in: delLabelIds,
                      },
                      is_del: IsDel.NO,
                    },
                  },
                ]
              : []),
            ...(labels
              .filter((label: any) => !!label.id)
              .map(
                ({
                  id,
                  icon,
                  text,
                  order,
                  color,
                }: {
                  id: string
                  icon: string
                  text: string
                  order: number
                  color: string
                }) => ({
                  data: {
                    icon,
                    text,
                    order,
                    color,
                    update_by: updateBy,
                  },
                  where: {
                    id,
                    is_del: IsDel.NO,
                  },
                }),
              ) || []),
          ],
          create: labels
            .filter((label: any) => !label.id)
            .map(
              ({
                icon,
                text,
                order,
                color,
              }: {
                icon: string
                text: string
                order: number
                color: string
              }) => ({
                icon,
                text,
                order,
                color,
                create_by: updateBy,
                update_by: updateBy,
              }),
            ),
        },
        update_by: updateBy,
      },
      include: {
        labels: true,
      },
      where: {
        id,
        is_del: IsDel.NO,
      },
    })
  }

  async remove(id: string, updateBy: string) {
    return this.prismaService.roadmap.update({
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
