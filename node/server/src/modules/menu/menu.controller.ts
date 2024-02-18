import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  UseGuards,
  UseFilters,
  BadRequestException,
  NotFoundException,
} from '@nestjs/common'
import { MenuService } from './menu.service'
import { CreateMenuDto } from './dto/create-menu.dto'
import { UpdateMenuDto } from './dto/update-menu.dto'
import { ApiTags } from '@nestjs/swagger'
import { JwtAuthGuard } from '@/common/guards/jwt-auth.guard'
import { HttpExceptionFilter } from '@/common/filters/http-exception.filter'
import { Public } from '@/common/decorators/public.decorator'
import { CurrentUser } from '@/common/decorators/user.decorator'

@Controller('menu')
@ApiTags('menu')
@UseGuards(JwtAuthGuard)
@UseFilters(new HttpExceptionFilter())
export class MenuController {
  constructor(private readonly menuService: MenuService) {}

  @Post()
  async create(
    @Body() createMenuDto: CreateMenuDto,
    @CurrentUser('id') createBy: string,
  ) {
    return this.menuService.create(createMenuDto, createBy)
  }

  @Public()
  @Get()
  async findAll() {
    return this.menuService.findAll()
  }

  @Public()
  @Get(':id')
  async findOne(@Param('id') id: string) {
    if (!id) {
      throw new BadRequestException()
    }

    const menu = await this.menuService.findOne(id)

    if (!menu) {
      throw new NotFoundException()
    }

    return menu
  }

  @Patch(':id')
  async update(
    @Param('id') id: string,
    @Body() updateMenuDto: UpdateMenuDto,
    @CurrentUser('id') updateBy: string,
  ) {
    if (!id) {
      throw new BadRequestException()
    }

    const menu = await this.menuService.update(id, updateMenuDto, updateBy)

    if (!menu) {
      throw new NotFoundException()
    }

    return menu
  }

  @Delete(':id')
  async remove(@Param('id') id: string, @CurrentUser('id') updateBy: string) {
    if (!id) {
      throw new BadRequestException()
    }

    const menu = await this.menuService.remove(id, updateBy)

    if (!menu) {
      throw new NotFoundException()
    }

    return menu
  }
}
