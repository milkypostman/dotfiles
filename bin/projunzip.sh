#!/bin/bash

for f in *.zip; do 
    g=${f%.zip}
    mkdir ${g}
    cd ${g}
    unzip ../${f}
    cd ..
done

