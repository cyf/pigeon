import {
  IsBoolean,
  IsEnum,
  IsInt,
  IsNotEmpty,
  IsOptional,
  IsString,
  MaxLength,
} from 'class-validator'
import { MenuType } from '@prisma/client'

export class CreateMenuDto {
  @IsOptional()
  @IsString()
  path?: string

  @IsNotEmpty()
  @IsString()
  @MaxLength(50)
  title: string

  @IsOptional()
  @IsString()
  icon: string

  @IsOptional()
  @IsInt()
  order: number

  @IsNotEmpty()
  @IsBoolean()
  shown: boolean

  @IsNotEmpty()
  @IsEnum(MenuType)
  menu_type: MenuType

  @IsOptional()
  @IsString()
  parent_id?: string

  @IsOptional()
  @IsString()
  permission_id?: string
}
