import { Test, TestingModule } from '@nestjs/testing'
import { UserRoleService } from './user-role.service'
import { PrismaModule } from '@/modules/prisma'

describe('UserRoleService', () => {
  let service: UserRoleService

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      imports: [PrismaModule],
      providers: [UserRoleService],
    }).compile()

    service = module.get<UserRoleService>(UserRoleService)
  })

  it('should be defined', () => {
    expect(service).toBeDefined()
  })
})
