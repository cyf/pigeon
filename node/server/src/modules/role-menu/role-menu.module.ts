import { Module } from '@nestjs/common'
import { RoleMenuService } from './role-menu.service'
import { RoleMenuController } from './role-menu.controller'
import { PrismaModule } from '@/modules/prisma'

@Module({
  imports: [PrismaModule],
  controllers: [RoleMenuController],
  providers: [RoleMenuService],
})
export class RoleMenuModule {}
