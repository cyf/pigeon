import { Module } from '@nestjs/common'
import { UserRoleService } from './user-role.service'
import { UserRoleController } from './user-role.controller'
import { PrismaModule } from '@/modules/prisma'

@Module({
  imports: [PrismaModule],
  controllers: [UserRoleController],
  providers: [UserRoleService],
})
export class UserRoleModule {}
