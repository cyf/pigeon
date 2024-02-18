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
import { UserPermissionService } from './user-permission.service'
import { CreateUserPermissionDto } from './dto/create-user-permission.dto'
import { UpdateUserPermissionDto } from './dto/update-user-permission.dto'
import { JwtAuthGuard } from '@/common/guards/jwt-auth.guard'
import { HttpExceptionFilter } from '@/common/filters/http-exception.filter'
import { Public } from '@/common/decorators/public.decorator'
import { CurrentUser } from '@/common/decorators/user.decorator'

@Controller('permission')
@ApiTags('user-permission')
@UseGuards(JwtAuthGuard)
@UseFilters(new HttpExceptionFilter())
export class UserPermissionController {
  constructor(private readonly userPermissionService: UserPermissionService) {}

  @Post()
  async create(
    @Body() createUserPermissionDto: CreateUserPermissionDto,
    @CurrentUser('id') createBy: string,
  ) {
    return this.userPermissionService.create(createUserPermissionDto, createBy)
  }

  @Public()
  @Get()
  async findAll() {
    return this.userPermissionService.findAll()
  }

  @Public()
  @Get(':id')
  async findOne(@Param('id') id: string) {
    if (!id) {
      throw new BadRequestException()
    }

    const userPermission = await this.userPermissionService.findOne(id)

    if (!userPermission) {
      throw new NotFoundException()
    }

    return userPermission
  }

  @Patch(':id')
  async update(
    @Param('id') id: string,
    @Body() updateUserPermissionDto: UpdateUserPermissionDto,
    @CurrentUser('id') updateBy: string,
  ) {
    if (!id) {
      throw new BadRequestException()
    }

    const userPermission = await this.userPermissionService.update(
      id,
      updateUserPermissionDto,
      updateBy,
    )

    if (!userPermission) {
      throw new NotFoundException()
    }

    return userPermission
  }

  @Delete(':id')
  async remove(@Param('id') id: string, @CurrentUser('id') updateBy: string) {
    if (!id) {
      throw new BadRequestException()
    }

    const userPermission = await this.userPermissionService.remove(id, updateBy)

    if (!userPermission) {
      throw new NotFoundException()
    }

    return userPermission
  }
}
