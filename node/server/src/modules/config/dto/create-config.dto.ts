import { IsNotEmpty, IsDateString, IsString, IsOptional } from 'class-validator'

export class CreateConfigDto {
  @IsNotEmpty()
  @IsString()
  key: string

  @IsOptional()
  @IsString()
  value?: string

  @IsOptional()
  @IsDateString()
  startDate?: Date

  @IsOptional()
  @IsDateString()
  endDate?: Date
}
