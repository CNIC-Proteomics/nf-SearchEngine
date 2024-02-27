process MZ_EXTRACTOR {

    label 'process_high'

    input:
    // tuple val(basename), path(ident_file), path(mz_file)
    val basename
    path ident_file
    path mz_file
    path ion_file

    output:
    path("*_quant.tsv", emit: ofile)
    path("*.log", emit: log)

    script:

    // // get the extension from the first input file. Should be equal in the channel collect.
    // def ident_prefix = ident_files.first().getExtension()
    // // get the extension from the first input file. Should be equal in the channel collect.
    // def mzml_prefix = mzml_files.first().getExtension()

    // get the file name without extension
    // def indent_fname = ident_files.first().getBaseName()
    // println("COMBINE2: ${indent_fname}")


    // // create quantification file based on file extension
    // def mz_file = "${indent_fname}.mzML"

    // define log file
    def log_file ="${task.process.tokenize(':')[-1].toLowerCase()}.log"

    """
    source ${MZEXTRACTOR_HOME}/env/bin/activate && python ${MZEXTRACTOR_HOME}/mz_extractor.py -i "${ident_file}" -z "${mz_file}" -r "${ion_file}" -o "." > "${log_file}" 2>&1
    """
}

// process MZ_EXTRACTOR {

//     label 'process_high'

//     input:
//     path ident_files
//     path mzml_files
//     path ion_file

//     output:
//     path("*.log", emit: log)

//     script:
//     // define log file
//     def log_file ="${task.process.tokenize(':')[-1].toLowerCase()}.log"

//     // """
//     // echo source ${MZEXTRACTOR_HOME}/env/bin/activate && python ${MZEXTRACTOR_HOME}/mz_extractor.py -i "*.${ident_prefix}" -z "*.${mzml_prefix}" -r "${ion_file}" -o "." > "${log_file}" 2>&1
//     // """
//     """
//     echo source ${MZEXTRACTOR_HOME}/env/bin/activate && python ${MZEXTRACTOR_HOME}/mz_extractor.py -i "${ident_files}" -z "${mzml_files}" -r "${ion_file}" -o "." > "${log_file}" 2>&1
//     """
// }
