#!/bin/bash

#check if there is artifacts folder
FOLDER="artifacts"


if [ ! -d "$FOLDER" ]; then
    echo "Folder '$FOLDER' does not exist. Creating it..."
    mkdir "$FOLDER"
else
    echo "Folder '$FOLDER' already exists."
fi

# check if there is artifacts/labeldata folder
DATASOURCE_FOLDER="artifacts/labeldata"
if [ ! -d "$DATASOURCE_FOLDER" ]; then
    echo "Folder '$DATASOURCE_FOLDER' does not exist. Creating it..."
    mkdir "$DATASOURCE_FOLDER"
    
else
    echo "Folder '$DATASOURCE_FOLDER' already exists."
fi

#Download the data to the datasource folder, fill your own code
datasource=/data/cmf_sage/sage-smoke-detection/training/artifacts/labeldata/all.tar.gz
cp $datasource $DATASOURCE_FOLDER

# run data loading scripts
DATA_LOADED_FOLDER="artifacts/loaded"
if [ ! -d "$DATA_LOADED_FOLDER" ]; then
    echo "Folder '$DATA_LOADED_FOLDER' does not exist. Creating it..."
    mkdir "$DATA_LOADED_FOLDER"
    
else
    echo "Folder '$DATA_LOADED_FOLDER' already exists."
fi

printf "\n[1/5] [RUNNING DATALOADING STEP         ]\n"
python src/data_collection.py $DATASOURCE_FOLDER $DATA_LOADED_FOLDER



cmf metadata push -p WILDFIRE
cmf artifact push -p WILDFIRE


