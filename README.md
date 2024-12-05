# nf-SearchEngine

nf-SearchEngine is a [Nextflow](https://www.nextflow.io/) pipeline that execute the MSFragger search engine for the peptide identification.

![Workflow schema](docs/images/pipeline.png)

nf-SearchEngine was developed by the Cardiovascular Proteomics Lab/Proteomic Unit at The National Centre for Cardiovascular Research (CNIC, https://www.cnic.es).

This application is licensed under a Creative Commons Attribution-NoDerivatives 4.0 International (CC BY-ND 4.0) License. For further details, read the https://creativecommons.org/licenses/by-nd/4.0/.


# Installation

## Prerequisites

Before you begin, ensure you have met the following requirements:

- A **Linux operating system** is needed on your machine.

## Linux operating system on Windows

If you are using a Windows operating system, refer to the section [Install WSL on Windows](docs/WSL.md) to set up a Linux operating system on your Windows machine.

## Install Singularity

For more information, read the [How to install Singularity](docs/SingularityCE.md) section.

## Install Nextflow

For more information, read the [How to install Nextflow](docs/Nextflow.md) section.

## Install Git

For more information, read the [How to install Git](docs/Git.md) section.


# Download the pipeline with the latest release

Export an environment variable to define the version:
```
export PIPELINE_VERSION=0.1.2
```

You can clone the latest release directly using git with the following command:
```
git clone https://github.com/CNIC-Proteomics/nf-SearchEngine.git --branch ${PIPELINE_VERSION} --recursive
```
With the *--recursive* parameter, the submodules repositories are cloned as well.

The list of releases is located on the [releases page](https://github.com/CNIC-Proteomics/nf-SearchEngine/releases).

# Download Singularity images

Navigate to the backends folder:
```
cd nf-SearchEngine/backends
```

You need to download the Singularity image for the pipeline, ensuring version compatibility with the Nextflow pipeline. See the above *versions* section:
```
singularity pull --arch amd64 library://proteomicscnic/next-launcher/search_engine:${PIPELINE_VERSION}
```

Create a symbolic link
```
ln -s search_engine_${PIPELINE_VERSION}.sif search_engine.sif
```


# Usage

## Execute the pipeline with test samples


1. Download test files
```
cd tests && \
wget https://zenodo.org/records/12750690/files/test_Raws_1.zip?download=1 -O test_Raws_1.zip && \
unzip test_Raws_1.zip -d test_Raws_1
```

2. Execute the pipeline:
```
nextflow \
    -log "/tmp/nextflow/log/nf-searchengine.log" \
    run main.nf   \
        -profile singularity \
        --raw_files "tests/test_Raws_1/raw_files/*" \
        --database "tests/test_Raws_1/database.fasta" \
        --add_decoys true \
        --decoy_prefix "DECOY_"\
        --msf_params_file "tests/test_Raws_1/msf_params_file.params" \
        --reporter_ion_isotopic "tests/test_Raws_1/reporter_ion_isotopic.tsv" \
        --outdir  "tests/test_Raws_1" \
        -resume
```


# Image Version History

For more information about the program version included within the Singularity version, refer to the [changelog](changelog.md) for the current version.
