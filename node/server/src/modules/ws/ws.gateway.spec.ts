import { Test, TestingModule } from '@nestjs/testing'
import { WsGateway } from './ws.gateway'
import { WsService } from './ws.service'
import { PrismaModule } from '@/modules/prisma'
import { AppModule } from '../../app.module'

describe('WsGateway', () => {
  let gateway: WsGateway

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      imports: [AppModule, PrismaModule],
      providers: [WsGateway, WsService],
    }).compile()

    gateway = module.get<WsGateway>(WsGateway)
  })

  it('should be defined', () => {
    expect(gateway).toBeDefined()
  })
})
