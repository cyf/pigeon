import { Module } from '@nestjs/common'
import { EmojiController } from './emoji.controller'
import { EmojiService } from './emoji.service'
import { PrismaModule } from '../prisma'

@Module({
  imports: [PrismaModule],
  controllers: [EmojiController],
  providers: [EmojiService],
})
export class EmojiModule {}
