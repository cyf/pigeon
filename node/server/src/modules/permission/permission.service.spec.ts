import { Test, TestingModule } from '@nestjs/testing'
import { PermissionService } from './permission.service'
import { PrismaModule } from '@/modules/prisma'

describe('PermissionService', () => {
  let service: PermissionService

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      imports: [PrismaModule],
      providers: [PermissionService],
    }).compile()

    service = module.get<PermissionService>(PermissionService)
  })

  it('should be defined', () => {
    expect(service).toBeDefined()
  })
})
