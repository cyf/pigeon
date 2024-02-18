import { Module } from '@nestjs/common'
import { UserPermissionService } from './user-permission.service'
import { UserPermissionController } from './user-permission.controller'
import { PrismaModule } from '@/modules/prisma'

@Module({
  imports: [PrismaModule],
  controllers: [UserPermissionController],
  providers: [UserPermissionService],
})
export class UserPermissionModule {}
