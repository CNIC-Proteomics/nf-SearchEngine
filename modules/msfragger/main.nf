process MSFRAGGER {

    label 'process_very_high'

    input:
    path input_files
    path database_name
    val decoy_prefix
    val params_msf

    output:
    path("*.tsv"), emit: ofile
    path("*.pin"), emit: ofile_pin
    path("*.pepXML"), emit: ofile_pepXML
    path("*.params"), emit: ofile_param

    script:
    // get the extension from the first input file. Should be equal in the channel collect.
    def prefix = input_files.first().getExtension()
    // define log file
    def log_file ="${task.process.tokenize(':')[-1].toLowerCase()}.log"
    // define the task memory
    def task_memory = task.memory.toString().replace(' ','').replace('GB','g').replace('MB','m')

    // update the database file and decoy_prefix in the parameter file
    def params_data = Utils.updateMsfParams(params_msf, ['database_name': database_name, 'decoy_prefix': decoy_prefix] )
    // create param string
    def params_str = ""
    params_data.each { key, value -> params_str += "$key = $value\n" }
    // print the params data
    def params_file = new File("msfragger.params")

    """
    echo "${params_str}" > "${params_file}"
    java -Xmx"${task_memory}" -jar /opt/msfragger/MSFragger.jar "${params_file}"  *.${prefix}  > "${log_file}" 2>&1
    """

}
