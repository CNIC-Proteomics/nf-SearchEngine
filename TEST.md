# Usage

## Execute the pipeline with samples

The input files provided are open search results for mouse heteroplasmy (`heart tissue`) at the following URL:

https://zenodo.org/records/17912282/files/heteroplasmic_heart.zip?download=1


2.1. Execute the pipeline:
+ Run MSFragger with the mzML files as input.
+ Generate decoy proteins.
+ Extract quantifications from the mzML files.
+ Correct post-translational modifications (PTMs) using the REFMOD module.
```
nextflow \
    -log "/tmp/nextflow/log/nf-searchengine.log" \
    run main.nf   \
        -profile singularity \
        --create_mzml false \
        --add_decoys true \
        --raw_files "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-SearchEngine/samples/heteroplasmic_heart/inputs/mzMLs/*.mzML" \
        --database "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-SearchEngine/samples/heteroplasmic_heart/inputs/database.fasta" \
        --decoy_prefix "DECOY_"\
        --msf_params_file "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-SearchEngine/samples/heteroplasmic_heart/inputs/msf_params_file.params" \
        --reporter_ion_isotopic "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-SearchEngine/samples/heteroplasmic_heart/inputs/reporter_ion_isotopic.tsv" \
        --outdir  "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-SearchEngine/samples/heteroplasmic_heart/results" \
        -resume
```

+ You can download the input files for this `liver` sample from the study by Bagwan N, Bonzon-Kulichenko E, Calvo E, et al. [1] at the following URL:

https://zenodo.org/records/17912282/files/heteroplasmic_liver.zip?download=1

```
nextflow \
    -log "/tmp/nextflow/log/nf-searchengine.log" \
    run main.nf   \
        -profile singularity \
        --create_mzml false \
        --add_decoys true \
        --raw_files "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-SearchEngine/samples/heteroplasmic_liver/inputs/mzMLs/*.mzML" \
        --database "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-SearchEngine/samples/heteroplasmic_liver/inputs/database.fasta" \
        --decoy_prefix "DECOY_"\
        --msf_params_file "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-SearchEngine/samples/heteroplasmic_liver/inputs/msf_params_file.params" \
        --reporter_ion_isotopic "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-SearchEngine/samples/heteroplasmic_liver/inputs/reporter_ion_isotopic.tsv" \
        --outdir  "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-SearchEngine/samples/heteroplasmic_liver/results" \
        -resume
```

+ You can download the input files for this `muscle` sample from the study by Bagwan N, Bonzon-Kulichenko E, Calvo E, et al. [1] at the following URL:

https://zenodo.org/records/17912282/files/heteroplasmic_muscle.zip?download=1

```
nextflow \
    -log "/tmp/nextflow/log/nf-searchengine.log" \
    run main.nf   \
        -profile singularity \
        --create_mzml false \
        --add_decoys true \
        --raw_files "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-SearchEngine/samples/heteroplasmic_muscle/inputs/mzMLs/*.mzML" \
        --database "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-SearchEngine/samples/heteroplasmic_muscle/inputs/database.fasta" \
        --decoy_prefix "DECOY_"\
        --msf_params_file "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-SearchEngine/samples/heteroplasmic_muscle/inputs/msf_params_file.params" \
        --reporter_ion_isotopic "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-SearchEngine/samples/heteroplasmic_muscle/inputs/reporter_ion_isotopic.tsv" \
        --outdir  "/mnt/tierra/U_Proteomica/UNIDAD/Softwares/jmrodriguezc/nf-SearchEngine/samples/heteroplasmic_muscle/results" \
        -resume
```

