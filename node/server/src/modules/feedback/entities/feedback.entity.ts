import { CommonEntity } from '@/common/entities/common.entity'

export class Feedback extends CommonEntity {
  id: string
  title: string
  description: string
  files?: File[]
}

class File extends CommonEntity {
  id?: string
  url: string
  type?: string
  size?: number
  title?: string
}
