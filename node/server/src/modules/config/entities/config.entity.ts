import { CommonEntity } from '@/common/entities/common.entity'

export class Config extends CommonEntity {
  id: string
  key: string
  value?: string
  start_date?: Date
  end_date?: Date
}
