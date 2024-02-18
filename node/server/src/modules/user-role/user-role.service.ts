import { Injectable } from '@nestjs/common'
import { IsDel } from '@prisma/client'
import { CreateUserRoleDto } from './dto/create-user-role.dto'
import { UpdateUserRoleDto } from './dto/update-user-role.dto'
import { PrismaService } from '@/modules/prisma'

@Injectable()
export class UserRoleService {
  constructor(private readonly prismaService: PrismaService) {}

  async create(createUserRoleDto: CreateUserRoleDto, createBy: string) {
    const { user_id, role_id } = createUserRoleDto
    return this.prismaService.rolesOnUsers.create({
      data: {
        user_id,
        role_id,
        create_by: createBy,
        update_by: createBy,
      },
    })
  }

  async findAll() {
    return this.prismaService.rolesOnUsers.findMany({
      select: {
        id: true,
        user_id: true,
        role_id: true,
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
    return this.prismaService.rolesOnUsers.findUnique({
      select: {
        id: true,
        user_id: true,
        role_id: true,
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
    updateUserRoleDto: UpdateUserRoleDto,
    updateBy: string,
  ) {
    const { user_id, role_id } = updateUserRoleDto
    return this.prismaService.rolesOnUsers.update({
      data: {
        user_id,
        role_id,
        update_by: updateBy,
      },
      where: {
        id,
        is_del: IsDel.NO,
      },
    })
  }

  async remove(id: string, updateBy: string) {
    return this.prismaService.rolesOnUsers.update({
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
