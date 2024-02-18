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
import { RoleService } from './role.service'
import { CreateRoleDto } from './dto/create-role.dto'
import { UpdateRoleDto } from './dto/update-role.dto'
import { JwtAuthGuard } from '@/common/guards/jwt-auth.guard'
import { CurrentUser } from '@/common/decorators/user.decorator'
import { HttpExceptionFilter } from '@/common/filters/http-exception.filter'
import { Public } from '@/common/decorators/public.decorator'

@Controller()
@ApiTags('role')
@UseGuards(JwtAuthGuard)
@UseFilters(new HttpExceptionFilter())
export class RoleController {
  constructor(private readonly roleService: RoleService) {}

  @Post()
  async create(
    @Body() createRoleDto: CreateRoleDto,
    @CurrentUser('id') createBy: string,
  ) {
    return this.roleService.create(createRoleDto, createBy)
  }

  @Public()
  @Get()
  async findAll() {
    return this.roleService.findAll()
  }

  @Public()
  @Get(':id')
  async findOne(@Param('id') id: string) {
    if (!id) {
      throw new BadRequestException()
    }

    const role = await this.roleService.findOne(id)

    if (!role) {
      throw new NotFoundException()
    }

    return role
  }

  @Patch(':id')
  async update(
    @Param('id') id: string,
    @Body() updateRoleDto: UpdateRoleDto,
    @CurrentUser('id') updateBy: string,
  ) {
    if (!id) {
      throw new BadRequestException()
    }

    const role = await this.roleService.update(id, updateRoleDto, updateBy)

    if (!role) {
      throw new NotFoundException()
    }

    return role
  }

  @Delete(':id')
  async remove(@Param('id') id: string, @CurrentUser('id') updateBy: string) {
    if (!id) {
      throw new BadRequestException()
    }

    const role = await this.roleService.remove(id, updateBy)

    if (!role) {
      throw new NotFoundException()
    }

    return role
  }
}
