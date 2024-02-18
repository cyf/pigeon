import { CommonEntity } from '@/common/entities/common.entity'

export class Roadmap extends CommonEntity {
  id: string
  title: string
  description?: string
  from: Date
  to: Date
  background?: string
  labels: Label[]
}

class Label extends CommonEntity {
  id?: string
  icon: string
  text: string
  order: number
  color: string
}
