import { Injectable } from '@nestjs/common'
import { CreateWDto } from './dto/create-w.dto'
import { UpdateWDto } from './dto/update-w.dto'
import { PrismaService } from '@/modules/prisma'

@Injectable()
export class WsService {
  constructor(private readonly prismaService: PrismaService) {}

  create(createWDto: CreateWDto) {
    return 'This action adds a new w'
  }

  findAll() {
    return `This action returns all ws`
  }

  findOne(id: number) {
    return `This action returns a #${id} w`
  }

  update(id: number, updateWDto: UpdateWDto) {
    return `This action updates a #${id} w`
  }

  remove(id: number) {
    return `This action removes a #${id} w`
  }
}
