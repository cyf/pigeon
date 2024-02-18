import {
  ExecutionContext,
  forwardRef,
  Inject,
  Injectable,
  CanActivate,
  UnauthorizedException,
} from '@nestjs/common'
import { Reflector } from '@nestjs/core'
import { AuthService } from '@/modules/auth'
import { PERMISSIONS_KEY } from '@/common/decorators/permissions.decorator'

@Injectable()
export class PermissionsAuthGuard implements CanActivate {
  constructor(
    @Inject(forwardRef(() => AuthService))
    private readonly authService: AuthService,
    private readonly reflector: Reflector,
  ) {}

  async canActivate(context: ExecutionContext): Promise<boolean> {
    const requiredPermissions = this.reflector.getAllAndOverride<string[]>(
      PERMISSIONS_KEY,
      [context.getHandler(), context.getClass()],
    )

    if (requiredPermissions && requiredPermissions.length > 0) {
      const { user } = context.switchToHttp().getRequest()
      if (!user || !user.id) throw new UnauthorizedException()
      const permissions = await this.authService.getPermissions(user.id)
      const hasPermission = requiredPermissions.some((permission) =>
        permissions.has(permission),
      )
      if (!hasPermission) {
        throw new UnauthorizedException()
      }
    }
    return true
  }
}
