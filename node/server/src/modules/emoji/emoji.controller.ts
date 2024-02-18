import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Query,
  BadRequestException,
  NotFoundException,
  ParseIntPipe,
  UsePipes,
  ValidationPipe,
  UseGuards,
  UseFilters,
} from '@nestjs/common'
import { ApiTags } from '@nestjs/swagger'
import { CreateEmojiDto } from './dto/create-emoji.dto'
import { UpdateEmojiDto } from './dto/update-emoji.dto'
import { EmojiService } from './emoji.service'
import { Public } from '@/common/decorators/public.decorator'
import { JwtAuthGuard } from '@/common/guards/jwt-auth.guard'
import { CurrentUser } from '@/common/decorators/user.decorator'
import { HttpExceptionFilter } from '@/common/filters/http-exception.filter'

@Controller('emoji')
@ApiTags('emoji')
@UseGuards(JwtAuthGuard)
@UseFilters(new HttpExceptionFilter())
export class EmojiController {
  constructor(private readonly emojiService: EmojiService) {}

  @Post()
  async create(
    @Body() createEmojiDto: CreateEmojiDto,
    @CurrentUser('id') createBy: string,
  ) {
    return this.emojiService.create(createEmojiDto, createBy)
  }

  @Post('all')
  async createAll(
    @Body() createEmojiDtoList: CreateEmojiDto[],
    @CurrentUser('id') createBy: string,
  ) {
    return this.emojiService.createAll(createEmojiDtoList, createBy)
  }

  @Public()
  @Get()
  @UsePipes(new ValidationPipe({ transform: true }))
  async findAll(
    @Query('page', ParseIntPipe) pageParam: number,
    @Query('page_size', ParseIntPipe) pageSizeParam: number,
  ) {
    return this.emojiService.findAll(pageParam, pageSizeParam)
  }

  @Public()
  @Get(':id')
  async findOne(@Param('id') id: string) {
    if (!id) {
      throw new BadRequestException()
    }

    const emoji = await this.emojiService.findOne(id)

    if (!emoji) {
      throw new NotFoundException()
    }

    return emoji
  }

  @Patch(':id')
  async update(
    @Param('id') id: string,
    @Body() updateEmojiDto: UpdateEmojiDto,
    @CurrentUser('id') updateBy: string,
  ) {
    if (!id) {
      throw new BadRequestException()
    }

    const emoji = await this.emojiService.update(id, updateEmojiDto, updateBy)

    if (!emoji) {
      throw new NotFoundException()
    }

    return emoji
  }

  @Delete(':id')
  async remove(@Param('id') id: string, @CurrentUser('id') updateBy: string) {
    if (!id) {
      throw new BadRequestException()
    }

    const emoji = await this.emojiService.remove(id, updateBy)

    if (!emoji) {
      throw new NotFoundException()
    }

    return emoji
  }
}
