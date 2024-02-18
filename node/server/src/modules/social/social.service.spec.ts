import { Test, TestingModule } from '@nestjs/testing'
import { SocialService } from './social.service'
import { PrismaModule } from '../prisma'

describe('SocialService', () => {
  let service: SocialService

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      imports: [PrismaModule],
      providers: [SocialService],
    }).compile()

    service = module.get<SocialService>(SocialService)
  })

  it('should be defined', () => {
    expect(service).toBeDefined()
  })
})
