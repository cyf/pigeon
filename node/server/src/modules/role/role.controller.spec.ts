import { Test, TestingModule } from '@nestjs/testing'
import { RoleController } from './role.controller'
import { RoleService } from './role.service'
import { AppModule } from '../../app.module'
import { PrismaModule } from '@/modules/prisma'

describe('RoleController', () => {
  let controller: RoleController

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      imports: [AppModule, PrismaModule],
      controllers: [RoleController],
      providers: [RoleService],
    }).compile()

    controller = module.get<RoleController>(RoleController)
  })

  it('should be defined', () => {
    expect(controller).toBeDefined()
  })
})
