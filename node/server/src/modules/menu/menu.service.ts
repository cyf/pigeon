import { Injectable } from '@nestjs/common'
import { IsDel } from '@prisma/client'
import { CreateMenuDto } from './dto/create-menu.dto'
import { UpdateMenuDto } from './dto/update-menu.dto'
import { PrismaService } from '@/modules/prisma'

@Injectable()
export class MenuService {
  constructor(private readonly prismaService: PrismaService) {}

  async create(createMenuDto: CreateMenuDto, createBy: string) {
    const {
      path,
      title,
      icon,
      order,
      shown,
      menu_type,
      parent_id,
      permission_id,
    } = createMenuDto
    return this.prismaService.menu.create({
      data: {
        path,
        title,
        icon,
        order,
        shown,
        menu_type,
        parent_id,
        permission_id,
        create_by: createBy,
        update_by: createBy,
      },
    })
  }

  async findAll() {
    return this.prismaService.menu.findMany({
      select: {
        id: true,
        path: true,
        title: true,
        icon: true,
        order: true,
        shown: true,
        menu_type: true,
        parent_id: true,
        children: {
          select: {
            id: true,
            path: true,
            title: true,
            icon: true,
            order: true,
            shown: true,
            menu_type: true,
            parent_id: true,
            children: {
              select: {
                id: true,
                path: true,
                title: true,
                icon: true,
                order: true,
                shown: true,
                menu_type: true,
                parent_id: true,
                children: {
                  select: {
                    id: true,
                    path: true,
                    title: true,
                    icon: true,
                    order: true,
                    shown: true,
                    menu_type: true,
                    parent_id: true,
                    children: {
                      select: {
                        id: true,
                        path: true,
                        title: true,
                        icon: true,
                        order: true,
                        shown: true,
                        menu_type: true,
                        parent_id: true,
                        permission_id: true,
                        create_by: true,
                        create_date: true,
                        update_by: true,
                        update_date: true,
                      },
                      where: {
                        is_del: IsDel.NO,
                      },
                    },
                    permission_id: true,
                    create_by: true,
                    create_date: true,
                    update_by: true,
                    update_date: true,
                  },
                  where: {
                    is_del: IsDel.NO,
                  },
                },
                permission_id: true,
                create_by: true,
                create_date: true,
                update_by: true,
                update_date: true,
              },
              where: {
                is_del: IsDel.NO,
              },
            },
            permission_id: true,
            create_by: true,
            create_date: true,
            update_by: true,
            update_date: true,
          },
          where: {
            is_del: IsDel.NO,
          },
        },
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
    return this.prismaService.menu.findUnique({
      select: {
        id: true,
        path: true,
        title: true,
        icon: true,
        order: true,
        shown: true,
        menu_type: true,
        parent_id: true,
        children: {
          select: {
            id: true,
            path: true,
            title: true,
            icon: true,
            order: true,
            shown: true,
            menu_type: true,
            parent_id: true,
            permission_id: true,
            create_by: true,
            create_date: true,
            update_by: true,
            update_date: true,
          },
        },
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

  async update(id: string, updateMenuDto: UpdateMenuDto, updateBy: string) {
    const {
      path,
      title,
      icon,
      order,
      shown,
      menu_type,
      parent_id,
      permission_id,
    } = updateMenuDto
    return this.prismaService.menu.update({
      data: {
        path,
        title,
        icon,
        order,
        shown,
        menu_type,
        parent_id,
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
    return this.prismaService.menu.update({
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
