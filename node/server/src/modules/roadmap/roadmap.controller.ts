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
  Query,
  ParseIntPipe,
  UsePipes,
  ValidationPipe,
  UseGuards,
  UseFilters,
} from '@nestjs/common'
import { ApiTags } from '@nestjs/swagger'
import { CreateRoadmapDto } from './dto/create-roadmap.dto'
import { UpdateRoadmapDto } from './dto/update-roadmap.dto'
import { RoadmapService } from './roadmap.service'
import { Public } from '@/common/decorators/public.decorator'
import { JwtAuthGuard } from '@/common/guards/jwt-auth.guard'
import { CurrentUser } from '@/common/decorators/user.decorator'
import { HttpExceptionFilter } from '@/common/filters/http-exception.filter'

@Controller('roadmap')
@ApiTags('roadmap')
@UseGuards(JwtAuthGuard)
@UseFilters(new HttpExceptionFilter())
export class RoadmapController {
  constructor(private readonly roadmapService: RoadmapService) {}

  @Post()
  async create(
    @Body() createRoadmapDto: CreateRoadmapDto,
    @CurrentUser('id') createBy: string,
  ) {
    return this.roadmapService.create(createRoadmapDto, createBy)
  }

  @Public()
  @Get()
  @UsePipes(new ValidationPipe({ transform: true }))
  async findAll(
    @Query('year', ParseIntPipe) yearParam: number,
    @Query('month', ParseIntPipe) monthParam: number,
  ) {
    return this.roadmapService.findAll(yearParam, monthParam)
  }

  @Public()
  @Get(':id')
  async findOne(@Param('id') id: string) {
    if (!id) {
      throw new BadRequestException()
    }

    const roadmap = await this.roadmapService.findOne(id)

    if (!roadmap) {
      throw new NotFoundException()
    }

    return roadmap
  }

  @Patch(':id')
  async update(
    @Param('id') id: string,
    @Query('del_label_ids') delLabelIds: string[],
    @Body() updateRoadmapDto: UpdateRoadmapDto,
    @CurrentUser('id') updateBy: string,
  ) {
    if (!id) {
      throw new BadRequestException()
    }

    const roadmap = await this.roadmapService.update(
      id,
      delLabelIds,
      updateRoadmapDto,
      updateBy,
    )

    if (!roadmap) {
      throw new NotFoundException()
    }

    return roadmap
  }

  @Delete(':id')
  async remove(@Param('id') id: string, @CurrentUser('id') updateBy: string) {
    if (!id) {
      throw new BadRequestException()
    }

    const roadmap = await this.roadmapService.remove(id, updateBy)

    if (!roadmap) {
      throw new NotFoundException()
    }

    return roadmap
  }
}
