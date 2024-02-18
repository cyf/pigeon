import { Test, TestingModule } from '@nestjs/testing'
import { FeedbackController } from './feedback.controller'
import { FeedbackService } from './feedback.service'
import { AppModule } from '../../app.module'
import { PrismaModule } from '@/modules/prisma'

describe('FeedbackController', () => {
  let controller: FeedbackController

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      imports: [AppModule, PrismaModule],
      controllers: [FeedbackController],
      providers: [FeedbackService],
    }).compile()

    controller = module.get<FeedbackController>(FeedbackController)
  })

  it('should be defined', () => {
    expect(controller).toBeDefined()
  })
})
