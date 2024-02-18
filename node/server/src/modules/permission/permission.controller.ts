import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  UseGuards,
  BadRequestException,
  NotFoundException,
  UseFilters,
} from '@nestjs/common'
import { ApiTags } from '@nestjs/swagger'
import { PermissionService } from './permission.service'
import { CreatePermissionDto } from './dto/create-permission.dto'
import { UpdatePermissionDto } from './dto/update-permission.dto'
import { JwtAuthGuard } from '@/common/guards/jwt-auth.guard'
import { CurrentUser } from '@/common/decorators/user.decorator'
import { HttpExceptionFilter } from '@/common/filters/http-exception.filter'
import { Public } from '@/common/decorators/public.decorator'

@Controller('permission')
@ApiTags('permission')
@UseGuards(JwtAuthGuard)
@UseFilters(new HttpExceptionFilter())
export class PermissionController {
  constructor(private readonly permissionService: PermissionService) {}

  @Post()
  async create(
    @Body() createPermissionDto: CreatePermissionDto,
    @CurrentUser('id') createBy: string,
  ) {
    return this.permissionService.create(createPermissionDto, createBy)
  }

  @Public()
  @Get()
  async findAll() {
    return this.permissionService.findAll()
  }

  @Public()
  @Get(':id')
  async findOne(@Param('id') id: string) {
    if (!id) {
      throw new BadRequestException()
    }

    const permission = await this.permissionService.findOne(id)

    if (!permission) {
      throw new NotFoundException()
    }

    return permission
  }

  @Patch(':id')
  async update(
    @Param('id') id: string,
    @Body() updatePermissionDto: UpdatePermissionDto,
    @CurrentUser('id') updateBy: string,
  ) {
    if (!id) {
      throw new BadRequestException()
    }

    const permission = await this.permissionService.update(
      id,
      updatePermissionDto,
      updateBy,
    )

    if (!permission) {
      throw new NotFoundException()
    }

    return permission
  }

  @Delete(':id')
  async remove(@Param('id') id: string, @CurrentUser('id') updateBy: string) {
    if (!id) {
      throw new BadRequestException()
    }

    const permission = await this.permissionService.remove(id, updateBy)

    if (!permission) {
      throw new NotFoundException()
    }

    return permission
  }
}
