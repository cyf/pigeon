import { Test, TestingModule } from '@nestjs/testing'
import { RoleMenuController } from './role-menu.controller'
import { RoleMenuService } from './role-menu.service'
import { AppModule } from '../../app.module'
import { PrismaModule } from '@/modules/prisma'

describe('RoleMenuController', () => {
  let controller: RoleMenuController

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      imports: [AppModule, PrismaModule],
      controllers: [RoleMenuController],
      providers: [RoleMenuService],
    }).compile()

    controller = module.get<RoleMenuController>(RoleMenuController)
  })

  it('should be defined', () => {
    expect(controller).toBeDefined()
  })
})
