# nf-SearchEngine


# Usage
In production (Docker):
```
cd /opt/nf-SearchEngine (WSL)

cd S:/U_Proteomica/UNIDAD/DatosCrudos/jmrodriguezc/projects/nf-SearchEngine (PowerShell)

nextflow \
    -log "/opt/nextflow/log/nextflow.log" \
    run main.nf   \
        -params-file "/mnt/tierra/nf-SearchEngine/params/params.yml" \
        -resume

nextflow \
    -log "/opt/nextflow/log/nextflow.log" \
    run main.nf   \
        -with-tower http://localhost:8000/api \
        -params-file "/mnt/tierra/nf-SearchEngine/params/params.yml" \
        -resume
```

Debugging using Ubuntu (WSL):
```
cd /home/jmrodriguezc/projects/nf-SearchEngine

nextflow \
    -log "/var/log/nextflow/nextflow.log" \
    run main.nf   \
        -params-file "/home/jmrodriguezc/projects/nf-SearchEngine/params/params.yml" \
        -resume

nextflow \
    run main.nf   \
        -with-tower http://localhost:8000/api \
        -params-file "/home/jmrodriguezc/projects/nf-SearchEngine/params/params_in_wsl.yml" \
        -resume

```


