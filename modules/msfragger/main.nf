process MSF {

    label 'process_very_high'

    input:
    path input_files
    path database_name
    val  decoy_prefix
    val  msf_output_format
    val  msf_params_file

    output:
    path("*.tsv", emit: ofile)
    path("*.pin", optional: true)
    path("*.pepXML", optional: true)
    path("*.params", emit: ofile_param)

    script:
    // get the extension from the first input file. Should be equal in the channel collect.
    def prefix = input_files.first().getExtension()
    // define log file
    def log_file ="${task.process.tokenize(':')[-1].toLowerCase()}.log"
    // define the task memory
    def task_memory = task.memory.toString().replace(' ','').replace('GB','g').replace('MB','m')

    // update the database file and decoy_prefix in the parameter file
    def params_data = Utils.updateMsfParams(msf_params_file, ['database_name': database_name, 'decoy_prefix': decoy_prefix, 'output_format': msf_output_format] )
    // create param string
    def params_str = ""
    params_data.each { key, value -> params_str += "$key = $value\n" }
    // print the params data
    def params_file = new File("msfragger.params")

    """
    echo "${params_str}" > "${params_file}"
    java -Xmx"${task_memory}" -jar ${MSFRAGGER_HOME}/MSFragger.jar "${params_file}"  *.${prefix}  > "${log_file}" 2>&1
    """

}
