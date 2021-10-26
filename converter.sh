#!/bin/bash

DIR=$1
NAME="converted_ndpi"

OUTPUT_DIR="/data/idr0096-tratwal-marrowquant/20211026-converted-ndpis"
WORKING_DIR="/uod/idr/filesets/idr0096-tratwal-marrowquant/20210309-ftp-ndpi"
echo $WORKING_DIR

cd $OUTPUT_DIR
if [ ! -d $NAME ]
then
    mkdir $NAME
fi

cd "$WORKING_DIR/$DIR"
for v in *; do
    if [[ "${v##*.}" = "ndpi" ]]; then
        echo $v
        name=$(echo "$v" | cut -f 1 -d '.')
        name_zarr="$OUTPUT_DIR/$name.zarr"
        name_tiff="$OUTPUT_DIR/$name.ome.tiff"
        # run command to create ome-tiff and move ome-tiff
        bioformats2raw $v $name_zarr --series 0
        raw2ometiff $name_zarr $name_tiff
    fi
done
echo `ls $HOME/$NAME`