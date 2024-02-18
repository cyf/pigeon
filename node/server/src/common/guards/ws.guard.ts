import { CanActivate, ExecutionContext, Injectable } from '@nestjs/common'
import { WsException } from '@nestjs/websockets'
import { JwtService } from '@nestjs/jwt'
import { jwtConstants } from '@/common/constants'
import { IS_PUBLIC_KEY } from '@/common/decorators/public.decorator'
import { Reflector } from '@nestjs/core'

@Injectable()
export class WsAuthGuard implements CanActivate {
  constructor(
    private jwtService: JwtService,
    private reflector: Reflector,
  ) {}

  async canActivate(context: ExecutionContext): Promise<boolean> {
    const isPublic = this.reflector.getAllAndOverride<boolean>(IS_PUBLIC_KEY, [
      context.getHandler(),
      context.getClass(),
    ])
    if (isPublic) {
      return true
    }

    const request = context.switchToHttp().getRequest()
    const ws = context.switchToWs()
    const client = ws.getClient()
    const token = this.extractTokenFromHeader(client)
    if (!token) {
      throw new WsException('unauthorized')
    }
    try {
      // 💡 We're assigning the payload to the request object here
      // so that we can access it in our route handlers
      request['user'] = await this.jwtService.verifyAsync(token, {
        secret: jwtConstants.secret,
      })
    } catch {
      throw new WsException('unauthorized')
    }
    return true
  }

  private extractTokenFromHeader(client: any): string | undefined {
    const [type, token] =
      client.handshake.headers.authorization?.split(' ') ?? []
    return type === 'Bearer' ? token : undefined
  }
}
