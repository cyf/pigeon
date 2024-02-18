import { Test, TestingModule } from '@nestjs/testing'
import { UserPermissionController } from './user-permission.controller'
import { UserPermissionService } from './user-permission.service'
import { AppModule } from '../../app.module'
import { PrismaModule } from '@/modules/prisma'

describe('UserPermissionController', () => {
  let controller: UserPermissionController

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      imports: [AppModule, PrismaModule],
      controllers: [UserPermissionController],
      providers: [UserPermissionService],
    }).compile()

    controller = module.get<UserPermissionController>(UserPermissionController)
  })

  it('should be defined', () => {
    expect(controller).toBeDefined()
  })
})
