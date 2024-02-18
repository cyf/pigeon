import { Test, TestingModule } from '@nestjs/testing'
import { RolePermissionService } from './role-permission.service'
import { PrismaModule } from '@/modules/prisma'

describe('RolePermissionService', () => {
  let service: RolePermissionService

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      imports: [PrismaModule],
      providers: [RolePermissionService],
    }).compile()

    service = module.get<RolePermissionService>(RolePermissionService)
  })

  it('should be defined', () => {
    expect(service).toBeDefined()
  })
})
