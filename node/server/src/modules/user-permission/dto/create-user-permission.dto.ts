import { IsNotEmpty, IsString } from 'class-validator'

export class CreateUserPermissionDto {
  @IsNotEmpty()
  @IsString()
  user_id: string

  @IsNotEmpty()
  @IsString()
  permission_id: string
}
