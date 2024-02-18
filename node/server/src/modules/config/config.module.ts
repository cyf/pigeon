import { Module } from '@nestjs/common'
import { ConfigController } from './config.controller'
import { ConfigService } from './config.service'
import { PrismaModule } from '../prisma'

@Module({
  imports: [PrismaModule],
  controllers: [ConfigController],
  providers: [ConfigService],
})
export class ConfigModule {}
