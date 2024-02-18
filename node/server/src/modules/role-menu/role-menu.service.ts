import { Injectable } from '@nestjs/common'
import { IsDel } from '@prisma/client'
import { CreateRoleMenuDto } from './dto/create-role-menu.dto'
import { UpdateRoleMenuDto } from './dto/update-role-menu.dto'
import { PrismaService } from '@/modules/prisma'

@Injectable()
export class RoleMenuService {
  constructor(private readonly prismaService: PrismaService) {}

  async create(createRoleMenuDto: CreateRoleMenuDto, createBy: string) {
    const { role_id, menu_id } = createRoleMenuDto
    return this.prismaService.menusOnRoles.create({
      data: {
        role_id,
        menu_id,
        create_by: createBy,
        update_by: createBy,
      },
    })
  }

  async findAll() {
    return this.prismaService.menusOnRoles.findMany({
      select: {
        id: true,
        role_id: true,
        menu_id: true,
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
    return this.prismaService.menusOnRoles.findUnique({
      select: {
        id: true,
        role_id: true,
        menu_id: true,
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
    updateRoleMenuDto: UpdateRoleMenuDto,
    updateBy: string,
  ) {
    const { role_id, menu_id } = updateRoleMenuDto
    return this.prismaService.menusOnRoles.update({
      data: {
        role_id,
        menu_id,
        update_by: updateBy,
      },
      where: {
        id,
        is_del: IsDel.NO,
      },
    })
  }

  async remove(id: string, updateBy: string) {
    return this.prismaService.menusOnRoles.update({
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
