# nf-SearchEngine


# Usage
Executing using Ubuntu and Singularity (WSL - backend):
```
cd /home/jmrodriguezc/nf-SearchEngine

nextflow \
    -log "/tmp/nextflow/log/nf-search-engine.log" \
    run main.nf   \
        -profile singularity \
        --raw_files "/mnt/tierra/U_Proteomica/UNIDAD/DatosCrudos/jmrodriguezc/projects/nf-SearchEngine/tests/test1/inputs/raw_files/*" \
        --database "/mnt/tierra/U_Proteomica/UNIDAD/DatosCrudos/jmrodriguezc/projects/nf-SearchEngine/tests/test1/inputs/database.fasta" \
        --add_decoys true \
        --decoy_prefix "DECOY_" \
        --msf_params_file "/mnt/tierra/U_Proteomica/UNIDAD/DatosCrudos/jmrodriguezc/projects/nf-SearchEngine/tests/test1/inputs/msf_params_file.params" \
        --reporter_ion_isotopic "/mnt/tierra/U_Proteomica/UNIDAD/DatosCrudos/jmrodriguezc/projects/nf-SearchEngine/tests/test1/inputs/reporter_ion_isotopic.tsv" \
        --outdir  "/mnt/tierra/U_Proteomica/UNIDAD/DatosCrudos/jmrodriguezc/projects/nf-SearchEngine/tests/test1" \
        -resume
```


        <!-- --msf_params_file "/mnt/tierra/U_Proteomica/UNIDAD/DatosCrudos/jmrodriguezc/projects/nf-SearchEngine/tests/test1/inputs/params.yml" \ -->

<!-- Debugging using Ubuntu (Docker - backend):
```
cd /usr/local/nf-SearchEngine

nextflow \
    -log "/opt/nextflow/nextflow/log/nf-search-engine.log" \
    run main.nf   \
        --wkf "search_engine" \
        --inputs "/mnt/tierra/nf-SearchEngine/tests/test1/params/inputs_searchengine.yml" \
        --outdir  "/mnt/tierra/nf-SearchEngine/tests/test1" \
        -params-file "/mnt/tierra/nf-SearchEngine/tests/test1/params/params.yml" \
        -resume
``` -->



In Production using the Web Server