import { IsNotEmpty, IsString } from 'class-validator'

export class CreateUserRoleDto {
  @IsNotEmpty()
  @IsString()
  user_id: string

  @IsNotEmpty()
  @IsString()
  role_id: string
}
