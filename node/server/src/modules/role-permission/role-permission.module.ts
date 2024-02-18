import { Module } from '@nestjs/common'
import { RolePermissionService } from './role-permission.service'
import { RolePermissionController } from './role-permission.controller'
import { PrismaModule } from '@/modules/prisma'

@Module({
  imports: [PrismaModule],
  controllers: [RolePermissionController],
  providers: [RolePermissionService],
})
export class RolePermissionModule {}
