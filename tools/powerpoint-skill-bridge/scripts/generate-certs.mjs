import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import { generateCertificates } from "office-addin-dev-certs";

const certificateDirectory = path.join(os.homedir(), ".office-addin-dev-certs");
const requiredFiles = ["ca.crt", "localhost.crt", "localhost.key"]
  .map((fileName) => path.join(certificateDirectory, fileName));

if (!requiredFiles.every((filePath) => fs.existsSync(filePath))) {
  await generateCertificates();
}
