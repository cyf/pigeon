import { Test, TestingModule } from '@nestjs/testing'
import { SocialController } from './social.controller'
import { AppModule } from '../../app.module'
import { SocialService } from './social.service'
import { PrismaModule } from '@/modules/prisma'

describe('SocialController', () => {
  let controller: SocialController

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      imports: [AppModule, PrismaModule],
      controllers: [SocialController],
      providers: [SocialService],
    }).compile()

    controller = module.get<SocialController>(SocialController)
  })

  it('should be defined', () => {
    expect(controller).toBeDefined()
  })
})
