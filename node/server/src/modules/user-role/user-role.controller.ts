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
import { UserRoleService } from './user-role.service'
import { CreateUserRoleDto } from './dto/create-user-role.dto'
import { UpdateUserRoleDto } from './dto/update-user-role.dto'
import { JwtAuthGuard } from '@/common/guards/jwt-auth.guard'
import { HttpExceptionFilter } from '@/common/filters/http-exception.filter'
import { Public } from '@/common/decorators/public.decorator'
import { CurrentUser } from '@/common/decorators/user.decorator'

@Controller('role')
@ApiTags('user-role')
@UseGuards(JwtAuthGuard)
@UseFilters(new HttpExceptionFilter())
export class UserRoleController {
  constructor(private readonly userRoleService: UserRoleService) {}

  @Post()
  async create(
    @Body() createUserRoleDto: CreateUserRoleDto,
    @CurrentUser('id') createBy: string,
  ) {
    return this.userRoleService.create(createUserRoleDto, createBy)
  }

  @Public()
  @Get()
  async findAll() {
    return this.userRoleService.findAll()
  }

  @Public()
  @Get(':id')
  async findOne(@Param('id') id: string) {
    if (!id) {
      throw new BadRequestException()
    }

    const userRole = await this.userRoleService.findOne(id)

    if (!userRole) {
      throw new NotFoundException()
    }

    return userRole
  }

  @Patch(':id')
  async update(
    @Param('id') id: string,
    @Body() updateUserRoleDto: UpdateUserRoleDto,
    @CurrentUser('id') updateBy: string,
  ) {
    if (!id) {
      throw new BadRequestException()
    }

    const userRole = await this.userRoleService.update(
      id,
      updateUserRoleDto,
      updateBy,
    )

    if (!userRole) {
      throw new NotFoundException()
    }

    return userRole
  }

  @Delete(':id')
  async remove(@Param('id') id: string, @CurrentUser('id') updateBy: string) {
    if (!id) {
      throw new BadRequestException()
    }

    const userRole = await this.userRoleService.remove(id, updateBy)

    if (!userRole) {
      throw new NotFoundException()
    }

    return userRole
  }
}
