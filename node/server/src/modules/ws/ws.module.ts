import { Module } from '@nestjs/common'
import { PassportModule } from '@nestjs/passport'
import { JwtModule } from '@nestjs/jwt'
import { WsService } from './ws.service'
import { WsGateway } from './ws.gateway'
import { PrismaModule } from '@/modules/prisma'
import { UserModule } from '@/modules/user'
import { AuthModule } from '@/modules/auth'
import { jwtConstants } from '@/common/constants'

@Module({
  imports: [
    PrismaModule,
    UserModule,
    AuthModule,
    PassportModule,
    JwtModule.register({
      global: true,
      secret: jwtConstants.secret,
      signOptions: { expiresIn: 24 * 60 * 60 },
    }),
  ],
  providers: [WsGateway, WsService],
})
export class WsModule {}
