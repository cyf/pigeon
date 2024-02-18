import { UseFilters, UseGuards } from '@nestjs/common'
import {
  WebSocketGateway,
  SubscribeMessage,
  MessageBody,
  WebSocketServer,
  OnGatewayInit,
  WsResponse,
} from '@nestjs/websockets'
import { I18nContext, I18nService } from 'nestjs-i18n'
import { from, map, Observable } from 'rxjs'
import { Server } from 'ws'
import { WsService } from './ws.service'
// import { CreateWDto } from './dto/create-w.dto'
// import { UpdateWDto } from './dto/update-w.dto'
import { WebsocketExceptionFilter } from '@/common/filters/ws-exception.filter'
import { WsAuthGuard } from '@/common/guards/ws.guard'
import { Public } from '@/common/decorators/public.decorator'
import logger from '@/common/logger/logger'
import { CurrentUser } from '@/common/decorators/user.decorator'
import { WsThrottlerGuard } from '@/common/guards/ws.throttler.guard'

const basePath = process.env.NODE_ENV === 'production' ? 'homing-pigeon/' : ''

@WebSocketGateway({
  // for socket-io
  // http://127.0.0.1:3001/ws
  // namespace: `${basePath}ws`,
  // for ws
  // ws://127.0.0.1:3001/ws
  path: `/${basePath}ws`,
  cors: {
    // origin: '*',
    origin: [/chenyifaer\.com/, /localhost:3000/],
    methods: ['GET', 'POST'],
    credentials: true,
  },
})
@UseFilters(new WebsocketExceptionFilter())
@UseGuards(WsThrottlerGuard, WsAuthGuard)
export class WsGateway implements OnGatewayInit<Server> {
  @WebSocketServer()
  server: Server

  constructor(
    private readonly wsService: WsService,
    private readonly i18n: I18nService,
  ) {}

  @Public()
  @SubscribeMessage('hello')
  hello(@MessageBody() data: any): string {
    logger.debug('this.i18n', this.i18n.t, I18nContext.current())
    return this.i18n.t('common.HELLO', { lang: I18nContext.current().lang })
  }

  @Public()
  @SubscribeMessage('hello2')
  hello2(@MessageBody() data: any): string {
    return 'hello2'
  }

  @SubscribeMessage('events')
  findAll(
    @MessageBody() data: any,
    @CurrentUser('id') operator: string,
  ): Observable<WsResponse<number>> {
    console.log('operator', operator)
    return from([1, 2, 3]).pipe(
      map((item) => ({ event: 'events', data: item })),
    )
  }

  @Public()
  @SubscribeMessage('identity')
  async identity(socket: any, @MessageBody() data: number): Promise<number> {
    return data
  }

  afterInit(server: Server): any {
    // console.log('server', server)
  }

  // @SubscribeMessage('createW')
  // create(@MessageBody() createWDto: CreateWDto) {
  //   return this.wsService.create(createWDto)
  // }
  //
  // @SubscribeMessage('findAllWs')
  // findAll() {
  //   return this.wsService.findAll()
  // }
  //
  // @SubscribeMessage('findOneW')
  // findOne(@MessageBody() id: number) {
  //   return this.wsService.findOne(id)
  // }
  //
  // @SubscribeMessage('updateW')
  // update(@MessageBody() updateWDto: UpdateWDto) {
  //   return this.wsService.update(updateWDto.id, updateWDto)
  // }
  //
  // @SubscribeMessage('removeW')
  // remove(@MessageBody() id: number) {
  //   return this.wsService.remove(id)
  // }
}
