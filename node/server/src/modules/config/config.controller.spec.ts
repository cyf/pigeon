import { Test, TestingModule } from '@nestjs/testing'
import { ConfigController } from './config.controller'
import { ConfigService } from './config.service'
import { AppModule } from '../../app.module'
import { PrismaModule } from '@/modules/prisma'

describe('ConfigController', () => {
  let controller: ConfigController

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      imports: [AppModule, PrismaModule],
      controllers: [ConfigController],
      providers: [ConfigService],
    }).compile()

    controller = module.get<ConfigController>(ConfigController)
  })

  it('should be defined', () => {
    expect(controller).toBeDefined()
  })
})
