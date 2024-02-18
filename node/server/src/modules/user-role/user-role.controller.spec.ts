import { Test, TestingModule } from '@nestjs/testing'
import { UserRoleController } from './user-role.controller'
import { UserRoleService } from './user-role.service'
import { AppModule } from '../../app.module'
import { PrismaModule } from '@/modules/prisma'

describe('UserRoleController', () => {
  let controller: UserRoleController

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      imports: [AppModule, PrismaModule],
      controllers: [UserRoleController],
      providers: [UserRoleService],
    }).compile()

    controller = module.get<UserRoleController>(UserRoleController)
  })

  it('should be defined', () => {
    expect(controller).toBeDefined()
  })
})
