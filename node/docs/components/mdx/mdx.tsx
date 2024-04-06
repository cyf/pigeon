import { useMDXComponent } from "next-contentlayer/hooks";
import PostLink from "./link";
import PostImage from "./image";
import PostBanner from "./banner";

const mdxComponents = {
  Link: PostLink,
  Image: PostImage,
  Banner: PostBanner,
};

interface MdxProps {
  code: string;
}

export function Mdx({ code }: MdxProps) {
  const Component = useMDXComponent(code);

  return (
    <article className="prose prose-lg max-w-none break-words text-lg text-gray-600 prose-headings:text-gray-900 prose-h2:scroll-mt-28 prose-p:leading-normal prose-a:font-normal prose-a:text-[#2262af] hover:prose-a:underline prose-blockquote:border-none prose-blockquote:pl-0 prose-blockquote:font-medium prose-blockquote:italic prose-blockquote:text-gray-900 prose-strong:font-medium prose-strong:text-gray-900 prose-code:text-[#2262af] dark:text-gray-300 dark:prose-headings:text-gray-100 dark:prose-a:text-[#2262af] dark:prose-blockquote:text-gray-100 dark:prose-strong:text-gray-100 dark:prose-code:text-[#2262af]">
      <Component components={{ ...mdxComponents }} />
    </article>
  );
}
