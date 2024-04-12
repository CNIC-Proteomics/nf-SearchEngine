process MSF {
    tag "${order}"
    label 'process_very_high'

    input:
    val order
    path input_files
    val params_file

    output:
    path("*.tsv", emit: ofile)
    path("*.pin", optional: true)
    path("*.pepXML", optional: true)

    script:
    // get the extension from the first input file. Should be equal in the channel collect.
    def prefix = input_files.first().getExtension()
    // define log file
    def log_file ="${task.process.tokenize(':')[-1].toLowerCase()}.log"
    // define the task memory
    def task_memory = task.memory.toString().replace(' ','').replace('GB','g').replace('MB','m')

    """
    java -Xmx"${task_memory}" -jar ${MSFRAGGER_HOME}/MSFragger.jar "${params_file}"  *.${prefix}  > "${log_file}" 2>&1
    """

}
