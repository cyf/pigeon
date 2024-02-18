import { Test, TestingModule } from '@nestjs/testing'
import { CarouselService } from './carousel.service'
import { PrismaModule } from '@/modules/prisma'

describe('CarouselService', () => {
  let service: CarouselService

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      imports: [PrismaModule],
      providers: [CarouselService],
    }).compile()

    service = module.get<CarouselService>(CarouselService)
  })

  it('should be defined', () => {
    expect(service).toBeDefined()
  })
})
