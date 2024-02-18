import { Test, TestingModule } from '@nestjs/testing'
import { CarouselController } from './carousel.controller'
import { CarouselService } from './carousel.service'
import { AppModule } from '../../app.module'
import { PrismaModule } from '@/modules/prisma'

describe('CarouselController', () => {
  let controller: CarouselController

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      imports: [AppModule, PrismaModule],
      controllers: [CarouselController],
      providers: [CarouselService],
    }).compile()

    controller = module.get<CarouselController>(CarouselController)
  })

  it('should be defined', () => {
    expect(controller).toBeDefined()
  })
})
