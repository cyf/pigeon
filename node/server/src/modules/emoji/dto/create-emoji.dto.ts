import {
  IsNotEmpty,
  IsString,
  IsUrl,
  IsNumber,
  Matches,
  IsOptional,
} from 'class-validator'

export class CreateEmojiDto {
  @IsNotEmpty()
  @IsString()
  @IsUrl({ protocols: ['http', 'https'] })
  image: string

  @IsOptional()
  @IsString()
  type?: string

  @IsOptional()
  @IsNumber()
  size?: number

  @IsOptional()
  @IsString()
  text?: string

  @IsOptional()
  @IsString()
  @Matches(RegExp('^(#|0x)([0-9a-fA-F]{6}|[0-9a-fA-F]{8})$'))
  color?: string
}
