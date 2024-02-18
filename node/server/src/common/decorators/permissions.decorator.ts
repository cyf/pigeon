import { SetMetadata, applyDecorators, UseGuards } from '@nestjs/common'
import { JwtAuthGuard } from '../guards/jwt-auth.guard'
import { PermissionsAuthGuard } from '../guards/permission.guard'

export const PERMISSIONS_KEY = 'permissions'

export const Permissions = (...permissions: string[]) =>
  applyDecorators(
    SetMetadata(PERMISSIONS_KEY, permissions),
    UseGuards(JwtAuthGuard, PermissionsAuthGuard),
  )
