import { Test, TestingModule } from '@nestjs/testing'
import { RoadmapService } from './roadmap.service'
import { PrismaModule } from '../prisma'

describe('RoadmapService', () => {
  let service: RoadmapService

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      imports: [PrismaModule],
      providers: [RoadmapService],
    }).compile()

    service = module.get<RoadmapService>(RoadmapService)
  })

  it('should be defined', () => {
    expect(service).toBeDefined()
  })
})
