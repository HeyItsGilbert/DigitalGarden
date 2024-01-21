import { QuartzComponentConstructor } from "./types"

export default (() => {
  function Footer() {
    return (
      <script src="https://giscus.app/client.js"
        data-repo="HeyItsGilbert/PKM"
        data-repo-id="R_kgDOK_O8yA"
        data-category="Announcements"
        data-category-id="DIC_kwDOK_O8yM4CcHlb"
        data-mapping="pathname"
        data-strict="0"
        data-reactions-enabled="1"
        data-emit-metadata="0"
        data-input-position="bottom"
        data-theme="preferred_color_scheme"
        data-lang="en"
        crossorigin="anonymous"
        async>
      </script>
    )
  }

  return Footer
}) satisfies QuartzComponentConstructor