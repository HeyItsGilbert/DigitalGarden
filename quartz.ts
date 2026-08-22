import { loadQuartzConfig, loadQuartzLayout } from "./quartz/plugins/loader/config-loader"
import { componentRegistry } from "./quartz/components/registry"

// quartz.config.yaml can't express function-typed plugin options (YAML has no
// function type), so the recent-notes filter is set here instead. The override
// key must match the plugin's npm source string exactly (see extractPluginName
// in quartz/plugins/loader/config-loader.ts) — NOT the escaped name used inside
// the generated .quartz/plugins wrapper, which does not match at lookup time.
componentRegistry.setOptionOverrides("@quartz-community/recent-notes", {
  filter: (f: { slug?: string }) => !f.slug?.startsWith("readwise/"),
})

const config = await loadQuartzConfig()
export default config
export const layout = await loadQuartzLayout()
