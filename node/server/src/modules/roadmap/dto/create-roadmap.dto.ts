import {
  IsNotEmpty,
  IsInt,
  IsUrl,
  IsString,
  Matches,
  MaxLength,
  IsArray,
  IsOptional,
  IsDateString,
} from 'class-validator'

export class CreateRoadmapDto {
  @IsNotEmpty()
  @IsString()
  @MaxLength(50)
  title: string

  @IsOptional()
  @IsString()
  @MaxLength(200)
  description?: string

  @IsNotEmpty()
  @IsDateString()
  from: Date

  @IsNotEmpty()
  @IsDateString()
  to: Date

  @IsOptional()
  @IsString()
  @Matches(RegExp('^(#|0x)([0-9a-fA-F]{6}|[0-9a-fA-F]{8})$'))
  background?: string

  @IsOptional()
  @IsArray()
  labels?: Label[]
}

class Label {
  @IsOptional()
  @IsString()
  id?: string

  @IsOptional()
  @IsString()
  @IsUrl({ protocols: ['http', 'https'] })
  icon?: string

  @IsString()
  @IsNotEmpty()
  @MaxLength(20)
  text: string

  @IsOptional()
  @IsInt()
  order?: number

  @IsOptional()
  @IsString()
  @Matches(RegExp('^(#|0x)([0-9a-fA-F]{6}|[0-9a-fA-F]{8})$'))
  color?: string
}
