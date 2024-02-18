import {
  IsNotEmpty,
  IsInt,
  IsDateString,
  IsUrl,
  IsString,
  Matches,
  IsOptional,
} from 'class-validator'

export class CreateCarouselDto {
  @IsNotEmpty()
  @IsString()
  @IsUrl({ protocols: ['http', 'https'] })
  image: string

  @IsNotEmpty()
  @IsInt()
  order: number

  @IsOptional()
  @IsString()
  text?: string

  @IsOptional()
  @IsString()
  @Matches(RegExp('^(#|0x)([0-9a-fA-F]{6}|[0-9a-fA-F]{8})$'))
  color?: string

  @IsOptional()
  @IsString()
  @IsUrl({ protocols: ['http', 'https'] })
  href?: string

  @IsOptional()
  @IsDateString()
  startDate?: Date

  @IsOptional()
  @IsDateString()
  endDate?: Date
}
