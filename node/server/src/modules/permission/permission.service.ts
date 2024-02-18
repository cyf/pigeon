import { Injectable } from '@nestjs/common'
import { CreatePermissionDto } from './dto/create-permission.dto'
import { UpdatePermissionDto } from './dto/update-permission.dto'
import { PrismaService } from '@/modules/prisma'
import { IsDel } from '@prisma/client'

@Injectable()
export class PermissionService {
  constructor(private readonly prismaService: PrismaService) {}

  async create(createPermissionDto: CreatePermissionDto, createBy: string) {
    const { name, description } = createPermissionDto
    return this.prismaService.role.create({
      data: {
        name,
        description,
        create_by: createBy,
        update_by: createBy,
      },
    })
  }

  async findAll() {
    return this.prismaService.permission.findMany({
      select: {
        id: true,
        name: true,
        description: true,
        create_by: true,
        create_date: true,
        update_by: true,
        update_date: true,
      },
      where: {
        is_del: IsDel.NO,
      },
    })
  }

  async findOne(id: string) {
    return this.prismaService.permission.findUnique({
      select: {
        id: true,
        name: true,
        description: true,
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
    updatePermissionDto: UpdatePermissionDto,
    updateBy: string,
  ) {
    const { name, description } = updatePermissionDto
    return this.prismaService.role.update({
      data: {
        name,
        description,
        update_by: updateBy,
      },
      where: {
        id,
        is_del: IsDel.NO,
      },
    })
  }

  async remove(id: string, updateBy: string) {
    return this.prismaService.permission.update({
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
