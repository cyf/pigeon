import { Test, TestingModule } from '@nestjs/testing'
import { MenuController } from './menu.controller'
import { MenuService } from './menu.service'
import { AppModule } from '../../app.module'
import { PrismaModule } from '@/modules/prisma'

describe('MenuController', () => {
  let controller: MenuController

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      imports: [AppModule, PrismaModule],
      controllers: [MenuController],
      providers: [MenuService],
    }).compile()

    controller = module.get<MenuController>(MenuController)
  })

  it('should be defined', () => {
    expect(controller).toBeDefined()
  })
})
