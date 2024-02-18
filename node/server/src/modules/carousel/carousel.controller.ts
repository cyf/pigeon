import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  BadRequestException,
  NotFoundException,
  UseGuards,
  UseFilters,
} from '@nestjs/common'
import { ApiTags } from '@nestjs/swagger'
import { CreateCarouselDto } from './dto/create-carousel.dto'
import { UpdateCarouselDto } from './dto/update-carousel.dto'
import { Carousel } from './entities/carousel.entity'
import { CarouselService } from './carousel.service'
import { Public } from '@/common/decorators/public.decorator'
import { JwtAuthGuard } from '@/common/guards/jwt-auth.guard'
import { CurrentUser } from '@/common/decorators/user.decorator'
import { HttpExceptionFilter } from '@/common/filters/http-exception.filter'

@Controller('carousel')
@ApiTags('carousel')
@UseGuards(JwtAuthGuard)
@UseFilters(new HttpExceptionFilter())
export class CarouselController {
  constructor(private readonly carouselService: CarouselService) {}

  @Post()
  async create(
    @Body() createCarouselDto: CreateCarouselDto,
    @CurrentUser('id') createBy: string,
  ): Promise<Carousel> {
    return this.carouselService.create(createCarouselDto, createBy)
  }

  @Public()
  @Get()
  async findAll() {
    return this.carouselService.findAll()
  }

  @Public()
  @Get(':id')
  async findOne(@Param('id') id: string) {
    if (!id) {
      throw new BadRequestException()
    }

    const carousel = await this.carouselService.findOne(id)

    if (!carousel) {
      throw new NotFoundException()
    }

    return carousel
  }

  @Patch(':id')
  async update(
    @Param('id') id: string,
    @Body() updateCarouselDto: UpdateCarouselDto,
    @CurrentUser('id') updateBy: string,
  ) {
    if (!id) {
      throw new BadRequestException()
    }

    const carousel = await this.carouselService.update(
      id,
      updateCarouselDto,
      updateBy,
    )

    if (!carousel) {
      throw new NotFoundException()
    }

    return carousel
  }

  @Delete(':id')
  async remove(@Param('id') id: string, @CurrentUser('id') updateBy: string) {
    if (!id) {
      throw new BadRequestException()
    }

    const carousel = await this.carouselService.remove(id, updateBy)

    if (!carousel) {
      throw new NotFoundException()
    }

    return carousel
  }
}
