import { Injectable } from '@nestjs/common'
import { IsDel, Prisma } from '@prisma/client'
import { CreateCarouselDto } from './dto/create-carousel.dto'
import { UpdateCarouselDto } from './dto/update-carousel.dto'
import { PrismaService } from '../prisma'

@Injectable()
export class CarouselService {
  constructor(private readonly prismaService: PrismaService) {}

  async create(createCarouselDto: CreateCarouselDto, createBy: string) {
    const { image, order, text, color, href, startDate, endDate } =
      createCarouselDto
    return this.prismaService.carousel.create({
      data: {
        image,
        order,
        text,
        color,
        href,
        start_date: startDate,
        end_date: endDate,
        create_by: createBy,
        update_by: createBy,
      },
    })
  }

  async findAll() {
    const currentDate = new Date()
    return this.prismaService.carousel.findMany({
      select: {
        id: true,
        image: true,
        order: true,
        text: true,
        color: true,
        href: true,
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
      orderBy: {
        order: Prisma.SortOrder.desc,
      },
    })
  }

  async findOne(id: string) {
    return this.prismaService.carousel.findUnique({
      select: {
        id: true,
        image: true,
        order: true,
        text: true,
        color: true,
        href: true,
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

  async update(
    id: string,
    updateCarouselDto: UpdateCarouselDto,
    updateBy: string,
  ) {
    const { image, order, text, color, href, startDate, endDate } =
      updateCarouselDto
    return this.prismaService.carousel.update({
      data: {
        image,
        order,
        text,
        color,
        href,
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
    return this.prismaService.carousel.update({
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
