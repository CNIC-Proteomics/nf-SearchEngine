process MZ_EXTRACTOR {
    tag "${order}"
    label 'process_high'

    input:
    val order
    tuple path(ident_file), path(mz_file)
    path ion_file

    output:
    path("*_quant.tsv", emit: ofile)
    path("*.log", emit: log)

    script:
    // define log file
    def log_file ="${task.process.tokenize(':')[-1].toLowerCase()}.log"

    """
    source ${MZEXTRACTOR_HOME}/env/bin/activate && python ${MZEXTRACTOR_HOME}/mz_extractor.py -i "${ident_file}" -z "${mz_file}" -r "${ion_file}" -o "." > "${log_file}" 2>&1
    """
}
