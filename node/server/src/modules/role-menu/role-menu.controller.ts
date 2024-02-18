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
import { RoleMenuService } from './role-menu.service'
import { CreateRoleMenuDto } from './dto/create-role-menu.dto'
import { UpdateRoleMenuDto } from './dto/update-role-menu.dto'
import { JwtAuthGuard } from '@/common/guards/jwt-auth.guard'
import { HttpExceptionFilter } from '@/common/filters/http-exception.filter'
import { Public } from '@/common/decorators/public.decorator'
import { CurrentUser } from '@/common/decorators/user.decorator'

@Controller('menu')
@ApiTags('role-menu')
@UseGuards(JwtAuthGuard)
@UseFilters(new HttpExceptionFilter())
export class RoleMenuController {
  constructor(private readonly roleMenuService: RoleMenuService) {}

  @Post()
  async create(
    @Body() createRoleMenuDto: CreateRoleMenuDto,
    @CurrentUser('id') createBy: string,
  ) {
    return this.roleMenuService.create(createRoleMenuDto, createBy)
  }

  @Public()
  @Get()
  async findAll() {
    return this.roleMenuService.findAll()
  }

  @Public()
  @Get(':id')
  async findOne(@Param('id') id: string) {
    if (!id) {
      throw new BadRequestException()
    }

    const rolePermission = await this.roleMenuService.findOne(id)

    if (!rolePermission) {
      throw new NotFoundException()
    }

    return rolePermission
  }

  @Patch(':id')
  async update(
    @Param('id') id: string,
    @Body() updateRoleMenuDto: UpdateRoleMenuDto,
    @CurrentUser('id') updateBy: string,
  ) {
    if (!id) {
      throw new BadRequestException()
    }

    const rolePermission = await this.roleMenuService.update(
      id,
      updateRoleMenuDto,
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

    const rolePermission = await this.roleMenuService.remove(id, updateBy)

    if (!rolePermission) {
      throw new NotFoundException()
    }

    return rolePermission
  }
}
