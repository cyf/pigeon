import { simpleGit, SimpleGit } from 'simple-git';
import * as fs from 'fs';
import { join } from 'path';

const git: SimpleGit = simpleGit({
  baseDir: process.cwd(),
  binary: 'git',
  maxConcurrentProcesses: 6,
  trimmed: false,
});

const run = async () => {
  const res = await git.log({
    maxCount: 10,
  })

  fs.writeFileSync(join( process.cwd(), './latest-commits.json'), JSON.stringify(res.all));
}

run()
