import {
  IsNotEmpty,
  IsString,
  MaxLength,
  Matches,
  IsArray,
  IsUrl,
  IsIn,
  IsEnum,
  IsOptional,
} from 'class-validator'
import { LinkType as LinkTypes, type LinkType } from '@prisma/client'

export class CreateSocialDto {
  @IsNotEmpty()
  @IsString()
  @MaxLength(30)
  title: string

  @IsOptional()
  @IsArray()
  subtitles?: SubTitle[]

  @IsOptional()
  @IsArray()
  tips?: Link[]

  @IsOptional()
  @IsArray()
  descriptions?: Description[]
}

class SubTitle {
  @IsOptional()
  @IsString()
  id?: string

  @IsNotEmpty()
  @IsString()
  title: string

  @IsOptional()
  @IsString()
  @Matches(RegExp('^(#|0x)([0-9a-fA-F]{6}|[0-9a-fA-F]{8})$'))
  color?: string
}

class Link {
  @IsOptional()
  @IsString()
  id?: string

  @IsNotEmpty()
  @IsEnum(LinkTypes)
  @IsIn([LinkTypes.link, LinkTypes.text])
  type: LinkType

  @IsOptional()
  @IsString()
  text?: string

  @IsOptional()
  @IsString()
  @IsUrl({ protocols: ['http', 'https', 'mailto'] })
  href?: string

  @IsOptional()
  @IsString()
  @Matches(RegExp('^(#|0x)([0-9a-fA-F]{6}|[0-9a-fA-F]{8})$'))
  color?: string
}

class Description {
  @IsOptional()
  @IsString()
  id?: string

  @IsOptional()
  @IsString()
  name?: string

  @IsOptional()
  @IsArray()
  links?: Link[]
}
