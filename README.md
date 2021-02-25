# section-io-deployment

## Summary

We faced problems deploying the nodejs app the Section.io stack.

To repro, follow the steps below:

1. Create a file `.env.local` and declare the variable like so:
    ```shell
    SECTION_TOKEN=1234567-5766-4fcd-b00d-219b9510d2cd:9625b8cd-fe96-4190-ac20-123456765412
    ```
   
2. Run `yarn install`

3. To run locally, execute `yarn dev`

4. To execute deployment, run these:
    ```shell
    yarn docker:build
    docker-compose run --rm builder
    ```

## Open questions

Please let me know where can I find description of these:

### `server.conf` file

What's that and what's the proper workflow for this file?

### Is it ok to run sectionctl as non-privileged user?

The docker image is run as a user UID=1000.  
All the required permissions are granted, but can the deploy fails be caused by the limitations?

### Alpine Linux

I succeeded to run sectionctl under Alpine using the respective linker (see Dockerfile).  
Seems everything is OK, but what's the possible issues?

## Contacts

Please reach me via email [vadym.milichev@ewave.com](mailto:vadym.milichev@ewave.com).
