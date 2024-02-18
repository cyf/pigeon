import { CommonEntity } from '@/common/entities/common.entity'

export class Emoji extends CommonEntity {
  id: string
  image: string
  type?: string
  size?: number
  text?: string
  color?: string
}
