import { IsNotEmpty, IsOptional, IsString, MaxLength } from 'class-validator'

export class CreatePermissionDto {
  @IsNotEmpty()
  @IsString()
  @MaxLength(50)
  name: string

  @IsOptional()
  @IsString()
  @MaxLength(200)
  description?: string
}
