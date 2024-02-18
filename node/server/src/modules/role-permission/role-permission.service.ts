import { Injectable } from '@nestjs/common'
import { IsDel } from '@prisma/client'
import { CreateRolePermissionDto } from './dto/create-role-permission.dto'
import { UpdateRolePermissionDto } from './dto/update-role-permission.dto'
import { PrismaService } from '@/modules/prisma'

@Injectable()
export class RolePermissionService {
  constructor(private readonly prismaService: PrismaService) {}

  async create(
    createRolePermissionDto: CreateRolePermissionDto,
    createBy: string,
  ) {
    const { role_id, permission_id } = createRolePermissionDto
    return this.prismaService.permissionsOnRoles.create({
      data: {
        role_id,
        permission_id,
        create_by: createBy,
        update_by: createBy,
      },
    })
  }

  async findAll() {
    return this.prismaService.permissionsOnRoles.findMany({
      select: {
        id: true,
        role_id: true,
        permission_id: true,
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
    return this.prismaService.permissionsOnRoles.findUnique({
      select: {
        id: true,
        role_id: true,
        permission_id: true,
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
    updateRolePermissionDto: UpdateRolePermissionDto,
    updateBy: string,
  ) {
    const { role_id, permission_id } = updateRolePermissionDto
    return this.prismaService.permissionsOnRoles.update({
      data: {
        role_id,
        permission_id,
        update_by: updateBy,
      },
      where: {
        id,
        is_del: IsDel.NO,
      },
    })
  }

  async remove(id: string, updateBy: string) {
    return this.prismaService.permissionsOnRoles.update({
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
