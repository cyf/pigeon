import { Test, TestingModule } from '@nestjs/testing'
import { UserPermissionService } from './user-permission.service'
import { PrismaModule } from '@/modules/prisma'

describe('UserPermissionService', () => {
  let service: UserPermissionService

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      imports: [PrismaModule],
      providers: [UserPermissionService],
    }).compile()

    service = module.get<UserPermissionService>(UserPermissionService)
  })

  it('should be defined', () => {
    expect(service).toBeDefined()
  })
})
