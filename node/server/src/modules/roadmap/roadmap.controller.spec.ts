import { Test, TestingModule } from '@nestjs/testing'
import { RoadmapController } from './roadmap.controller'
import { RoadmapService } from './roadmap.service'
import { AppModule } from '../../app.module'
import { PrismaModule } from '@/modules/prisma'

describe('RoadmapController', () => {
  let controller: RoadmapController

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      imports: [AppModule, PrismaModule],
      controllers: [RoadmapController],
      providers: [RoadmapService],
    }).compile()

    controller = module.get<RoadmapController>(RoadmapController)
  })

  it('should be defined', () => {
    expect(controller).toBeDefined()
  })
})
