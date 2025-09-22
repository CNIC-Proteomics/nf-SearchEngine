___
## 1.6

### Date 📅 *2025_08*

### Changes in detail

**rc1**
+ Moved the process container attribute from the modules.config file to nextflow.config.
+ Redefine the process container attribute.
+ Updated documentation:
  - Summary log in the pipeline execution (nextflow).
**rc2, rc3, rc4, rc5**
+ Fixing a bug related to reporting error output for ThermoRawFileParser.
**rc6**
+ Version format reduced from three segments to two (major.minor).
+ Updated documentation: Hardware specifications and Execution trace.
+ Changed the location where the tag order variable is assigned.

### Image Version history

+ Updated MSFragger to the new version (4.2).

| Singularity image (version)                                                                      | Code                                                                     | Version  |
|--------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------|----------|
| [search_engine:1.6](https://cloud.sylabs.io/library/proteomicscnic/next-launcher/search_engine)  |                                                                          |          |
|                                                                                                  | [MSFragger](https://msfragger.nesvilab.org)                              | 4.2      |
|                                                                                                  | [ThermoRawFileParser](https://github.com/compomics/ThermoRawFileParser)  | 1.4.5    |
|                                                                                                  | [bioDataHub (DecoyPYrat)](https://www.sanger.ac.uk/tool/decoypyrat/)     | 2.14     |
|                                                                                                  | [SearchToolkit](https://github.com/CNIC-Proteomics/SearchToolkit)        | 1.3      |
|                                                                                                  | [REFMOD](https://github.com/CNIC-Proteomics/ReFrag)                      | v0.4.5   |



___
## 0.1.5

### Date 📅 *2025_03*

### Changes in detail

+ 'base.config' file is deprecated.

+ Update REFMOD (ReFrag) module.


### Image Version history

+ ReFrag (REFMOD, version v0.4.5):
  - The REFMOD program has been included

| Singularity image (version)                                                                        | Code                                                                     | Version  |
|----------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------|----------|
| [search_engine:0.1.5](https://cloud.sylabs.io/library/proteomicscnic/next-launcher/search_engine)  |                                                                          |          |
|                                                                                                    | [MSFragger](https://msfragger.nesvilab.org)                              | 4.2-rc14 |
|                                                                                                    | [ThermoRawFileParser](https://github.com/compomics/ThermoRawFileParser)  | 1.4.5    |
|                                                                                                    | [bioDataHub (DecoyPYrat)](https://www.sanger.ac.uk/tool/decoypyrat/)     | 2.14     |
|                                                                                                    | [SearchToolkit](https://github.com/CNIC-Proteomics/SearchToolkit)        | 1.3      |
|                                                                                                    | [REFMOD](https://github.com/CNIC-Proteomics/ReFrag)                      | v0.4.5   |


___
## 0.1.4

### Date 📅 *2025_02*

### Changes in detail

+ The 'mz_extractor' is now an optional process.

+ The conditions for selecting the 'decoyPYrat' and 'ThermoRawParser' processes have been changed.


### Image Version history

+ bioDataHub (version 2.14):
  - Add new version of decoyPYrat (v3). In this version, the '|' character is replaced by '_'in the decoy comment line.
+ SearchToolkit (version 1.3):
  - 'mz_extractor': Change ProcessPoolExecutor to ThreadPoolExecutor.


| Singularity image (version)                                                                        | Code                                                                     | Version  |
|----------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------|----------|
| [search_engine:0.1.4](https://cloud.sylabs.io/library/proteomicscnic/next-launcher/search_engine)  |                                                                          |          |
|                                                                                                    | [MSFragger](https://msfragger.nesvilab.org)                              | 4.2-rc14 |
|                                                                                                    | [ThermoRawFileParser](https://github.com/compomics/ThermoRawFileParser)  | 1.4.5    |
|                                                                                                    | [bioDataHub (DecoyPYrat)](https://www.sanger.ac.uk/tool/decoypyrat/)     | 2.14     |
|                                                                                                    | [SearchToolkit](https://github.com/CNIC-Proteomics/SearchToolkit)        | 1.3      |



___
## 0.1.3

### Date 📅 *2024_12*

### Highlights

+ Updated the sample input files.

+ Upgraded the MSFragger version (4.2-rc14) with a patch that extends the precursor mass range.

### Changes

+ Upgraded the MSFragger version (4.2-rc14) with a patch that extends the precursor mass range.

+ Upgraded ThermoRawFileParser version.

+ Upgraded SearchToolkit version.

### Image Version history

| Version | Singularity image                                                                                  | Code                                                                     | Version  |
|---------|----------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------|----------|
| 0.1.3   | [search_engine:0.1.3](https://cloud.sylabs.io/library/proteomicscnic/next-launcher/search_engine)  |                                                                          |          |
|         |                                                                                                    | [MSFragger](https://msfragger.nesvilab.org)                              | 4.2-rc14 |
|         |                                                                                                    | [ThermoRawFileParser](https://github.com/compomics/ThermoRawFileParser)  | 1.4.5    |
|         |                                                                                                    | [DecoyPYrat](https://www.sanger.ac.uk/tool/decoypyrat/)                  | 2.13     |
|         |                                                                                                    | [SearchToolkit](https://github.com/CNIC-Proteomics/SearchToolkit)        | 1.2      |


___
## 0.1.2
```
DATE: 2024_11
```

### Highlights

+ Search Adaptation: Added a module that inserts the ScanID into search engine results.

### Changes

+ Created a 'SearchToolkit' repository to house the 'mz_extractor' program and other tools that adapt search engine results.

+ MSFragger adapted: execute process, then the output files overwrite the inputs (*.tsv).

+ Skip the method "mz_extractor" from a flag parameter (create_mzml).

### Image Version history

| Version | Singularity image                                                                                  | Code                                                                     | Version |
|---------|----------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------|---------|
| 0.1.2   | [search_engine:0.1.2](https://cloud.sylabs.io/library/proteomicscnic/next-launcher/search_engine)  |                                                                          |         |
|         |                                                                                                    | [MSFragger](https://msfragger.nesvilab.org)                              | 4.1     |
|         |                                                                                                    | [ThermoRawFileParser](https://github.com/compomics/ThermoRawFileParser)  | 1.4.2   |
|         |                                                                                                    | [DecoyPYrat](https://www.sanger.ac.uk/tool/decoypyrat/)                  | 2.13    |
|         |                                                                                                    | [SearchToolkit](https://github.com/CNIC-Proteomics/SearchToolkit)        | 1.1     |

___
## 0.1.1
```
DATE: 2024_10
```

### Highlights

+ DecoyPyRat: Optional outputs added when the database is copied.

+ Update the MSFragger version.

### Changes

+ DecoyPyRat: Optional outputs added when the database is copied.

### Image Version history

| Version | Description                  | Singularity image                                                                                  | Code                                                                     | Version |
|---------|------------------------------|----------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------|---------|
| 0.1.1   | Update MSFragger version     | [search_engine:0.1.1](https://cloud.sylabs.io/library/proteomicscnic/next-launcher/search_engine)  |                                                                          |         |
|         |                              |                                                                                                    | [MSFragger](https://msfragger.nesvilab.org)                              | 4.1     |
|         |                              |                                                                                                    | [ThermoRawFileParser](https://github.com/compomics/ThermoRawFileParser)  | 1.4.2   |
|         |                              |                                                                                                    | [DecoyPYrat](https://www.sanger.ac.uk/tool/decoypyrat/)                    | 2.13    |
|         |                              |                                                                                                    | [MZ_extractor](https://github.com/CNIC-Proteomics/mz_extractor)            | 1.0     |

___
## 0.1.0
```
DATE: 2024_07
```

### Highlights

+ Release the first stable version.

### Changes


### Image Version history

| Version | Description                  | Singularity image                                                                                  | Code                                                                     | Version |
|---------|------------------------------|----------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------|---------|
| 0.1.0   | First stable version         |                                                                                                    |                                                                          |         |
|         |                              | [search_engine:0.1.0](https://cloud.sylabs.io/library/proteomicscnic/next-launcher/search_engine)  |                                                                          |         |
|         |                              |                                                                                                    | [MSFragger](https://msfragger.nesvilab.org)                              | 3.8     |
|         |                              |                                                                                                    | [ThermoRawFileParser](https://github.com/compomics/ThermoRawFileParser)  | 1.4.2   |
|         |                              |                                                                                                    | [DecoyPYrat](https://www.sanger.ac.uk/tool/decoypyrat/)                    | 2.13    |
|         |                              |                                                                                                    | [MZ_extractor](https://github.com/CNIC-Proteomics/mz_extractor)            | 1.0     |

___
## 0.0.X
```
DATE: 2024_XX
```

### Highlights

+ Developing the beta version

