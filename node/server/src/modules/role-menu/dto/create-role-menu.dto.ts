import { IsNotEmpty, IsString } from 'class-validator'

export class CreateRoleMenuDto {
  @IsNotEmpty()
  @IsString()
  role_id: string

  @IsNotEmpty()
  @IsString()
  menu_id: string
}
