import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Query,
  Delete,
  BadRequestException,
  NotFoundException,
  UsePipes,
  ValidationPipe,
  ParseIntPipe,
  UseGuards,
  UseFilters,
} from '@nestjs/common'
import { ApiTags } from '@nestjs/swagger'
import { CreateSocialDto } from './dto/create-social.dto'
import { UpdateSocialDto } from './dto/update-social.dto'
import { Social } from './entities/social.entity'
import { SocialService } from './social.service'
import { Public } from '@/common/decorators/public.decorator'
import { JwtAuthGuard } from '@/common/guards/jwt-auth.guard'
import { CurrentUser } from '@/common/decorators/user.decorator'
import { HttpExceptionFilter } from '@/common/filters/http-exception.filter'

@Controller('social')
@ApiTags('social')
@UseGuards(JwtAuthGuard)
@UseFilters(new HttpExceptionFilter())
export class SocialController {
  constructor(private readonly socialService: SocialService) {}

  @Post()
  async create(
    @Body() createSocialDto: CreateSocialDto,
    @CurrentUser('id') createBy: string,
  ): Promise<Social> {
    return this.socialService.create(createSocialDto, createBy)
  }

  @Public()
  @Get()
  @UsePipes(new ValidationPipe({ transform: true }))
  async findAll(
    @Query('page', ParseIntPipe) pageParam: number,
    @Query('page_size', ParseIntPipe) pageSizeParam: number,
  ) {
    return this.socialService.findAll(pageParam, pageSizeParam)
  }

  @Public()
  @Get(':id')
  async findOne(@Param('id') id: string) {
    if (!id) {
      throw new BadRequestException()
    }

    const social = await this.socialService.findOne(id)

    if (!social) {
      throw new NotFoundException()
    }

    return social
  }

  @Patch(':id')
  async update(
    @Param('id') id: string,
    @Query('del_subtitle_ids') delSubtitleIds: string[],
    @Query('del_tip_ids') delTipIds: string[],
    @Query('del_desc_ids') delDescIds: string[],
    @Query('del_link_ids') delLinkIds: string[],
    @Body() updateSocialDto: UpdateSocialDto,
    @CurrentUser('id') updateBy: string,
  ) {
    if (!id) {
      throw new BadRequestException()
    }

    const social = await this.socialService.update(
      id,
      delSubtitleIds,
      delTipIds,
      delDescIds,
      delLinkIds,
      updateSocialDto,
      updateBy,
    )

    if (!social) {
      throw new NotFoundException()
    }

    return social
  }

  @Delete(':id')
  async remove(@Param('id') id: string, @CurrentUser('id') updateBy: string) {
    if (!id) {
      throw new BadRequestException()
    }

    const social = await this.socialService.remove(id, updateBy)

    if (!social) {
      throw new NotFoundException()
    }

    return social
  }
}
