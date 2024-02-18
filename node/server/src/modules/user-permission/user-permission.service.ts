import { Injectable } from '@nestjs/common'
import { IsDel } from '@prisma/client'
import { CreateUserPermissionDto } from './dto/create-user-permission.dto'
import { UpdateUserPermissionDto } from './dto/update-user-permission.dto'
import { PrismaService } from '@/modules/prisma'

@Injectable()
export class UserPermissionService {
  constructor(private readonly prismaService: PrismaService) {}

  async create(
    createUserPermissionDto: CreateUserPermissionDto,
    createBy: string,
  ) {
    const { user_id, permission_id } = createUserPermissionDto
    return this.prismaService.permissionsOnUsers.create({
      data: {
        user_id,
        permission_id,
        create_by: createBy,
        update_by: createBy,
      },
    })
  }

  async findAll() {
    return this.prismaService.permissionsOnUsers.findMany({
      select: {
        id: true,
        user_id: true,
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
    return this.prismaService.permissionsOnUsers.findUnique({
      select: {
        id: true,
        user_id: true,
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
    updateUserPermissionDto: UpdateUserPermissionDto,
    updateBy: string,
  ) {
    const { user_id, permission_id } = updateUserPermissionDto
    return this.prismaService.permissionsOnUsers.update({
      data: {
        user_id,
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
    return this.prismaService.permissionsOnUsers.update({
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
