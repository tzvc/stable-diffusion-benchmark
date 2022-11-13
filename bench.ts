import { writableStreamFromWriter } from "https://deno.land/std/streams/conversion.ts";

const PROMPT = "An astronaut riding a horse in the style of Andy Warhol";

const run = async (url: string, iteration: number, prompt: string) => {
  console.log(`Running benchmark for ${iteration} requests...`);
  const outputFolder = `./output/bench-${Date.now()}`;
  await Deno.mkdir(outputFolder, { recursive: true });
  console.log(`Saving output to ./${outputFolder}`);
  let totalMs = 0;
  let minMs = Infinity;
  let maxMs = 0;

  for (let i = 1; i <= iteration; i++) {
    const start = performance.now();
    const res = await fetch(`${url}/?prompt=${encodeURIComponent(prompt)}`);
    const ms = performance.now() - start;
    minMs = Math.min(minMs, ms);
    maxMs = Math.max(maxMs, ms);
    totalMs += ms;
    if (res.body) {
      const file = await Deno.open(`${outputFolder}/${i}.png`, {
        write: true,
        create: true,
      });
      const writableStream = writableStreamFromWriter(file);
      await res.body.pipeTo(writableStream);
    }
    console.log(`${i}/${iteration} -> ${ms.toFixed(2)}ms`);
  }

  console.log(`Total time: ${totalMs / 1000}s`);
  console.log(`Min time: ${minMs}ms`);
  console.log(`Max time: ${maxMs}ms`);
  console.log(`Avg. time: ${totalMs / iteration}ms`);
};

run("http://34.84.185.4:5000", 100, PROMPT);
