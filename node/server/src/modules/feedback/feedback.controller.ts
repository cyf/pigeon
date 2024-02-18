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
import { CreateFeedbackDto } from './dto/create-feedback.dto'
import { UpdateFeedbackDto } from './dto/update-feedback.dto'
import { FeedbackService } from './feedback.service'
import { Public } from '@/common/decorators/public.decorator'
import { JwtAuthGuard } from '@/common/guards/jwt-auth.guard'
import { CurrentUser } from '@/common/decorators/user.decorator'
import { HttpExceptionFilter } from '@/common/filters/http-exception.filter'

@Controller('feedback')
@ApiTags('feedback')
@UseGuards(JwtAuthGuard)
@UseFilters(new HttpExceptionFilter())
export class FeedbackController {
  constructor(private readonly feedbackService: FeedbackService) {}

  @Post()
  async create(
    @Body() createFeedbackDto: CreateFeedbackDto,
    @CurrentUser('id') createBy: string,
  ) {
    return this.feedbackService.create(createFeedbackDto, createBy)
  }

  @Public()
  @Get()
  @UsePipes(new ValidationPipe({ transform: true }))
  async findAll(
    @Query('page', ParseIntPipe) pageParam: number,
    @Query('page_size', ParseIntPipe) pageSizeParam: number,
  ) {
    return this.feedbackService.findAll(pageParam, pageSizeParam)
  }

  @Public()
  @Get(':id')
  async findOne(@Param('id') id: string) {
    if (!id) {
      throw new BadRequestException()
    }

    const feedback = await this.feedbackService.findOne(id)

    if (!feedback) {
      throw new NotFoundException()
    }

    return feedback
  }

  @Patch(':id')
  async update(
    @Param('id') id: string,
    @Query('del_file_ids') delFileIds: string[],
    @Body() updateFeedbackDto: UpdateFeedbackDto,
    @CurrentUser('id') updateBy: string,
  ) {
    if (!id) {
      throw new BadRequestException()
    }

    const feedback = await this.feedbackService.update(
      id,
      delFileIds,
      updateFeedbackDto,
      updateBy,
    )

    if (!feedback) {
      throw new NotFoundException()
    }

    return feedback
  }

  @Delete(':id')
  async remove(@Param('id') id: string, @CurrentUser('id') updateBy: string) {
    if (!id) {
      throw new BadRequestException()
    }

    const feedback = await this.feedbackService.remove(id, updateBy)

    if (!feedback) {
      throw new NotFoundException()
    }

    return feedback
  }
}
