# ooc(rock)-beanchmark
Benchmark programs for rock, an implemention of ooc programming langugae

Clone this, or just copy them to your repo.

This repo tries to **compare** ooc and c but not find the best algorithms/libraries.
The code and algorithm should be as similar as possible.

Language |OOC | C | Rust | OOC(GC=off) | GO | Nimrod |
---------| --------- | -------- | ------- | ----- | ---| --- |
Flags| --pr --cc=clang --O3 | -pipe -Wall -O3 -fomit-frame-pointer -march=native -mfpmath=sse -msse3 -lm | -C opt-level=3 -C lto | --pr --cc=clang --O3 -lpthread --gc=off | N/A | --opt:speed -d:release --cc:clang |
nbody| 7.9 |4.65| 5.10 | 5.3 | 7.3 | 6.7 |
b-tree| 29.8 | 16.5 | N/A | N/A | 39.9 | 28.5 |
