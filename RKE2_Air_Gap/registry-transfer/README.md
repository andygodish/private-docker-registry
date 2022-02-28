# registry-transfer tool

Used to pull each variation of an image tag located in a source registry (built primarily to pull transfer images from bermuda.af.mil:11234 to registry.bermuda.af.mil). Images will be retagged and pushed to registry.bermuda.af.mil.

## Requirements

Docker

## Instructions

`bash scripts/retag_and_push_images.sh`

Enter source registry 
    examples: 
        1. bermuda.af.mil:11234 (old nexus)
        2. registry1.dso.mil (Iron Bank)

Enter image name

