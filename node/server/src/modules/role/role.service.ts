import { Injectable } from '@nestjs/common'
import { CreateRoleDto } from './dto/create-role.dto'
import { UpdateRoleDto } from './dto/update-role.dto'
import { PrismaService } from '@/modules/prisma'
import { IsDel, Prisma } from '@prisma/client'

@Injectable()
export class RoleService {
  constructor(private readonly prismaService: PrismaService) {}

  async create(createRoleDto: CreateRoleDto, createBy: string) {
    const { name, description } = createRoleDto
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
    return this.prismaService.role.findMany({
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
    return this.prismaService.role.findUnique({
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

  async update(id: string, updateRoleDto: UpdateRoleDto, updateBy: string) {
    const { name, description } = updateRoleDto
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
    return this.prismaService.role.update({
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
