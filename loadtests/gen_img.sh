#!/usr/bin/env bash

OUT_DIR=rnd_imgs

mkdir -p "$OUT_DIR"

for ((i = 0; i < 500; i++)); do
    convert -size 500x500 xc:wheat +noise random "$OUT_DIR"/img$(printf %03d "$i").png
done
