import { Test, TestingModule } from '@nestjs/testing'
import { WsService } from './ws.service'
import { PrismaModule } from '@/modules/prisma'

describe('WsService', () => {
  let service: WsService

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      imports: [PrismaModule],
      providers: [WsService],
    }).compile()

    service = module.get<WsService>(WsService)
  })

  it('should be defined', () => {
    expect(service).toBeDefined()
  })
})
