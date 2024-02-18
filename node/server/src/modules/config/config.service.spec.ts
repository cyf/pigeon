import { Test, TestingModule } from '@nestjs/testing'
import { ConfigService } from './config.service'
import { PrismaModule } from '../prisma'

describe('ConfigService', () => {
  let service: ConfigService

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      imports: [PrismaModule],
      providers: [ConfigService],
    }).compile()

    service = module.get<ConfigService>(ConfigService)
  })

  it('should be defined', () => {
    expect(service).toBeDefined()
  })
})
