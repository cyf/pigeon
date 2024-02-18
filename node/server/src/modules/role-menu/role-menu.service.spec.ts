import { Test, TestingModule } from '@nestjs/testing'
import { RoleMenuService } from './role-menu.service'
import { PrismaModule } from '@/modules/prisma'

describe('RoleMenuService', () => {
  let service: RoleMenuService

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      imports: [PrismaModule],
      providers: [RoleMenuService],
    }).compile()

    service = module.get<RoleMenuService>(RoleMenuService)
  })

  it('should be defined', () => {
    expect(service).toBeDefined()
  })
})
