import { CommonEntity } from '@/common/entities/common.entity'
import { LinkType } from '@prisma/client'

export class Social extends CommonEntity {
  id: string
  title: string
  subtitles?: SubTitle[]
  tips?: Link[]
  descriptions?: Description[]
}

class SubTitle extends CommonEntity {
  id?: string
  title: string
  color?: string
}

class Link extends CommonEntity {
  id?: string
  type: LinkType
  text?: string
  href?: string
  color?: string
}

class Description extends CommonEntity {
  id?: string
  name?: string
  links?: Link[]
}
