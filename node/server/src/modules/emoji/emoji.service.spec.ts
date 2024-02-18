import { Test, TestingModule } from '@nestjs/testing'
import { EmojiService } from './emoji.service'
import { PrismaModule } from '../prisma'

describe('EmojiService', () => {
  let service: EmojiService

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      imports: [PrismaModule],
      providers: [EmojiService],
    }).compile()

    service = module.get<EmojiService>(EmojiService)
  })

  it('should be defined', () => {
    expect(service).toBeDefined()
  })
})
