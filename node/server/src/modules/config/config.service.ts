import { Injectable } from '@nestjs/common'
import { IsDel } from '@prisma/client'
import { CreateConfigDto } from './dto/create-config.dto'
import { UpdateConfigDto } from './dto/update-config.dto'
import { PrismaService } from '../prisma'

@Injectable()
export class ConfigService {
  constructor(private readonly prismaService: PrismaService) {}

  async create(createConfigDto: CreateConfigDto, createBy: string) {
    const { key, value, startDate, endDate } = createConfigDto
    return this.prismaService.config.create({
      data: {
        key,
        value,
        start_date: startDate,
        end_date: endDate,
        create_by: createBy,
        update_by: createBy,
      },
    })
  }

  async findAll() {
    const currentDate = new Date()
    return this.prismaService.config.findMany({
      select: {
        id: true,
        key: true,
        value: true,
        start_date: true,
        end_date: true,
        create_by: true,
        create_date: true,
        update_by: true,
        update_date: true,
      },
      where: {
        OR: [
          {
            start_date: null,
            end_date: null,
          },
          {
            start_date: { not: null, gte: currentDate },
            end_date: { not: null, lte: currentDate },
          },
          {
            start_date: null,
            end_date: { not: null, lte: currentDate },
          },
          {
            start_date: { not: null, gte: currentDate },
            end_date: null,
          },
        ],
        AND: [
          {
            is_del: IsDel.NO,
          },
        ],
      },
    })
  }

  async findOne(id: string) {
    return this.prismaService.config.findUnique({
      select: {
        id: true,
        key: true,
        value: true,
        start_date: true,
        end_date: true,
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

  async update(id: string, updateConfigDto: UpdateConfigDto, updateBy: string) {
    const { key, value, startDate, endDate } = updateConfigDto
    return this.prismaService.config.update({
      data: {
        key,
        value,
        start_date: startDate,
        end_date: endDate,
        update_by: updateBy,
      },
      where: {
        id,
        is_del: IsDel.NO,
      },
    })
  }

  async remove(id: string, updateBy: string) {
    return this.prismaService.config.update({
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
