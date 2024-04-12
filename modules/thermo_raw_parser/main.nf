process THERMO_RAW_PARSER {
    tag "${order}"
    label 'process_high'

    input:
    val order
    path input_file

    output:
    // select the output prefix depending on the given format
    def prefix = 'mzML'
    switch (params.thermo_parser_format) {
        case 0: // MGF
            prefix = 'mgf'
            break;
        case 1: // mzML
            prefix = 'mzML'
            break;
        case 2: // indexed mzML (default)
            prefix = 'mzML'
            break;
        case 3: // Parquet
            prefix = 'parquet'
            break;
        default:
            prefix = 'mzML'
            break; 
    }
    path("*.${prefix}", emit: ofile)
    path("*.log", emit: log)

    script:
    // define files
    def log_file ="${input_file.baseName}.log"

    """
    mono ${THERMORAWFILEPARSER_HOME}/ThermoRawFileParser.exe -i "${input_file}" -f "${params.thermo_parser_format}" > "${log_file}" 2>&1
    """

    // mv "${input_file.getParent()}/${input_file.baseName}.${prefix}" .

}
