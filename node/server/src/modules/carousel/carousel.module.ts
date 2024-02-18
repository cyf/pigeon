import { Module } from '@nestjs/common'
import { CarouselController } from './carousel.controller'
import { CarouselService } from './carousel.service'
import { PrismaModule } from '../prisma'

@Module({
  imports: [PrismaModule],
  controllers: [CarouselController],
  providers: [CarouselService],
})
export class CarouselModule {}
