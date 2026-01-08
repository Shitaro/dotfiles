import fs from "node:fs"
import path from "node:path"
import { fileURLToPath } from "node:url"

import { writeToProfile } from "karabiner.ts"

const dir = path.dirname(fileURLToPath(import.meta.url))
const rulesPath = path.join(dir, "karabiner.rules.json")
const rulesJson = JSON.parse(fs.readFileSync(rulesPath, "utf8"))

if (!Array.isArray(rulesJson?.rules)) {
  throw new Error("karabiner.rules.json missing rules array")
}

writeToProfile("Default profile", rulesJson.rules)
