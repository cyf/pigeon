import { Test, TestingModule } from '@nestjs/testing'
import { PermissionController } from './permission.controller'
import { PermissionService } from './permission.service'
import { AppModule } from '../../app.module'
import { PrismaModule } from '@/modules/prisma'

describe('PermissionController', () => {
  let controller: PermissionController

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      imports: [AppModule, PrismaModule],
      controllers: [PermissionController],
      providers: [PermissionService],
    }).compile()

    controller = module.get<PermissionController>(PermissionController)
  })

  it('should be defined', () => {
    expect(controller).toBeDefined()
  })
})
