import { CommonEntity } from '@/common/entities/common.entity'

export class Carousel extends CommonEntity {
  id: string
  image: string
  order: number
  text?: string
  color?: string
  href?: string
  start_date?: Date
  end_date?: Date
}
