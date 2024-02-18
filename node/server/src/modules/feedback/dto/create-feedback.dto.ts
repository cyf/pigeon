import {
  IsNotEmpty,
  IsString,
  IsUrl,
  IsNumber,
  MaxLength,
  IsArray,
  IsOptional,
} from 'class-validator'

export class CreateFeedbackDto {
  @IsNotEmpty()
  @IsString()
  @MaxLength(100)
  title: string

  @IsNotEmpty()
  @IsString()
  @MaxLength(500)
  description: string

  @IsOptional()
  @IsArray()
  files?: File[]
}

class File {
  @IsOptional()
  @IsString()
  id?: string

  @IsNotEmpty()
  @IsString()
  @IsUrl({ protocols: ['http', 'https'] })
  url: string

  @IsOptional()
  @IsString()
  type?: string

  @IsOptional()
  @IsNumber()
  size?: number

  @IsOptional()
  @IsString()
  title?: string
}
