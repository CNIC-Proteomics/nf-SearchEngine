# nf-SearchEngine


# Usage
Debugging using Ubuntu (Docker - backend):
```
cd /usr/local/nf-SearchEngine

nextflow \
    -log "/opt/nextflow/nextflow/log/nf-search-engine.log" \
    run main.nf   \
        --wkf "search_engine" \
        --inputs "/mnt/tierra/nf-SearchEngine/tests/test1/params/inputs_searchengine.yml" \
        --outdir  "/mnt/tierra/nf-SearchEngine/tests/test1" \
        --params_file "/mnt/tierra/nf-SearchEngine/tests/test1/params/params.yml" \
        -resume
```

In Production using the Web Server