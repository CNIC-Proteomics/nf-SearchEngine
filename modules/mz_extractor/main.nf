process MZ_EXTRACTOR {

    label 'process_high'

    input:
    ident_files, mzml_files from combine_indent_quant
    path ion_file

    output:
    path("*.log", emit: log)

    script:
    // get the extension from the first input file. Should be equal in the channel collect.
    def ident_prefix = ident_files.first().getExtension()
    // get the extension from the first input file. Should be equal in the channel collect.
    def mzml_prefix = mzml_files.first().getExtension()
    // define log file
    def log_file ="${task.process.tokenize(':')[-1].toLowerCase()}.log"

    // """
    // echo source ${MZEXTRACTOR_HOME}/env/bin/activate && python ${MZEXTRACTOR_HOME}/mz_extractor.py -i "*.${ident_prefix}" -z "*.${mzml_prefix}" -r "${ion_file}" -o "." > "${log_file}" 2>&1
    // """
    """
    echo source ${MZEXTRACTOR_HOME}/env/bin/activate && python ${MZEXTRACTOR_HOME}/mz_extractor.py -i "${ident_files}" -z "${mzml_files}" -r "${ion_file}" -o "." > "${log_file}" 2>&1
    """

}
