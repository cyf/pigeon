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
import { CreateConfigDto } from './dto/create-config.dto'
import { UpdateConfigDto } from './dto/update-config.dto'
import { Config } from './entities/config.entity'
import { ConfigService } from './config.service'
import { Public } from '@/common/decorators/public.decorator'
import { JwtAuthGuard } from '@/common/guards/jwt-auth.guard'
import { CurrentUser } from '@/common/decorators/user.decorator'
import { HttpExceptionFilter } from '@/common/filters/http-exception.filter'

@Controller('config')
@ApiTags('config')
@UseGuards(JwtAuthGuard)
@UseFilters(new HttpExceptionFilter())
export class ConfigController {
  constructor(private readonly configService: ConfigService) {}

  @Post()
  async create(
    @Body() createConfigDto: CreateConfigDto,
    @CurrentUser('id') createBy: string,
  ): Promise<Config> {
    return this.configService.create(createConfigDto, createBy)
  }

  @Public()
  @Get()
  async findAll() {
    return this.configService.findAll()
  }

  @Public()
  @Get(':id')
  async findOne(@Param('id') id: string) {
    if (!id) {
      throw new BadRequestException()
    }

    const config = await this.configService.findOne(id)

    if (!config) {
      throw new NotFoundException()
    }

    return config
  }

  @Patch(':id')
  async update(
    @Param('id') id: string,
    @Body() updateConfigDto: UpdateConfigDto,
    @CurrentUser('id') updateBy: string,
  ) {
    if (!id) {
      throw new BadRequestException()
    }

    const config = await this.configService.update(
      id,
      updateConfigDto,
      updateBy,
    )

    if (!config) {
      throw new NotFoundException()
    }

    return config
  }

  @Delete(':id')
  async remove(@Param('id') id: string, @CurrentUser('id') updateBy: string) {
    if (!id) {
      throw new BadRequestException()
    }

    const config = await this.configService.remove(id, updateBy)

    if (!config) {
      throw new NotFoundException()
    }

    return config
  }
}
