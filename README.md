# ooc(rock)-beanchmark
Benchmark programs for rock, an implemention of ooc programming langugae

Clone this, or just copy them to your repo.

This repo tries to **compare** ooc and c but not find the best algorithms/libraries.
The code and algorithm should be as similar as possible.

Language |OOC | C | Rust |
---------| --------- | -------- | ------- |
Flags| --pr --cc=clang --O3 | -pipe -Wall -O3 -fomit-frame-pointer -march=native -mfpmath=sse -msse3 -lm | -C opt-level=3 -C lto |
nbody|5.29 |4.65| 5.10
b-tree| 16.95 | 16.45|
