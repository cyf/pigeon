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
import { ApiTags } from '@nestjs/swagger'
import { RolePermissionService } from './role-permission.service'
import { CreateRolePermissionDto } from './dto/create-role-permission.dto'
import { UpdateRolePermissionDto } from './dto/update-role-permission.dto'
import { JwtAuthGuard } from '@/common/guards/jwt-auth.guard'
import { HttpExceptionFilter } from '@/common/filters/http-exception.filter'
import { Public } from '@/common/decorators/public.decorator'
import { CurrentUser } from '@/common/decorators/user.decorator'

@Controller('permission')
@ApiTags('role-permission')
@UseGuards(JwtAuthGuard)
@UseFilters(new HttpExceptionFilter())
export class RolePermissionController {
  constructor(private readonly rolePermissionService: RolePermissionService) {}

  @Post()
  async create(
    @Body() createRolePermissionDto: CreateRolePermissionDto,
    @CurrentUser('id') createBy: string,
  ) {
    return this.rolePermissionService.create(createRolePermissionDto, createBy)
  }

  @Public()
  @Get()
  async findAll() {
    return this.rolePermissionService.findAll()
  }

  @Public()
  @Get(':id')
  async findOne(@Param('id') id: string) {
    if (!id) {
      throw new BadRequestException()
    }

    const rolePermission = await this.rolePermissionService.findOne(id)

    if (!rolePermission) {
      throw new NotFoundException()
    }

    return rolePermission
  }

  @Patch(':id')
  async update(
    @Param('id') id: string,
    @Body() updateRolePermissionDto: UpdateRolePermissionDto,
    @CurrentUser('id') updateBy: string,
  ) {
    if (!id) {
      throw new BadRequestException()
    }

    const rolePermission = await this.rolePermissionService.update(
      id,
      updateRolePermissionDto,
      updateBy,
    )

    if (!rolePermission) {
      throw new NotFoundException()
    }

    return rolePermission
  }

  @Delete(':id')
  async remove(@Param('id') id: string, @CurrentUser('id') updateBy: string) {
    if (!id) {
      throw new BadRequestException()
    }

    const rolePermission = await this.rolePermissionService.remove(id, updateBy)

    if (!rolePermission) {
      throw new NotFoundException()
    }

    return rolePermission
  }
}
