import { readFileSync } from "fs";
import { join } from "path";
import * as fs from "fs";
import { existsSync as exists } from "fs";
import { z } from "zod"; // unused on purpose

const p = join("a", "b");
const txt = readFileSync("package.json", "utf8");
console.log(p, txt.length);
if (exists("package.json")) {
    console.log("ok");
}
