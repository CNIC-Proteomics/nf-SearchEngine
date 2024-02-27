//
// Create channel for input file
//

import org.yaml.snakeyaml.Yaml

// Define a function to check which parameters are missing in the dictionary
def getMissingParams(Map dictionary, List params) {
    def missingParams = []
    // Iterate over each parameter in the list
    for (param in params) {
        // Check if the parameter exists in the dictionary
        if (!dictionary.containsKey(param)) {
            // If parameter is missing, add it to the list of missing parameters
            missingParams.add(param)
        }
    }
    // Stop from the missing parameters
    if (!missingParams.isEmpty()) {
        exit 1, "ERROR: Missing parameters in dictionary: ${missingParams}"
    }
    // Return the list of missing parameters
    return missingParams
}

workflow CREATE_INPUT_CHANNEL_DECOYPYRAT {
    take:
    input_files

    main:

    // read the file with input parameters
    fi = new FileInputStream(new File(input_files))
    // create yaml
    inputs = new Yaml().load(fi)

    // stop from the missing parameters
    def requiredParams = ['database']
    getMissingParams(inputs, requiredParams)

    // create channels from input files
    database = Channel.fromPath("${inputs.database}", checkIfExists: true)

    // // add the parameters into params variable
    // def fp = new FileInputStream(new File(params_file))
    // new Yaml().load(fp).each({ k, v -> params[k] = v })

    emit:
    ch_database       = database
}

workflow CREATE_INPUT_CHANNEL_THERMORAWPARSER {
    take:
    input_files

    main:

    // read the file with input parameters
    f = new FileInputStream(new File(input_files))
    // create yaml
    inputs = new Yaml().load(f)

    // stop from the missing parameters
    def requiredParams = ['raw_files']
    getMissingParams(inputs, requiredParams)

    // create channels from input files
    raw_files = Channel.fromPath("${inputs.raw_files}", checkIfExists: true)

    emit:
    ch_raws           = raw_files
}

workflow CREATE_INPUT_CHANNEL_MSFRAGGER {
    take:
    input_files

    main:

    // read the file with input parameters
    f = new FileInputStream(new File(input_files))
    // create yaml
    inputs = new Yaml().load(f)

    // stop from the missing parameters
    def requiredParams = ['database','raw_files','msf_params_file']
    getMissingParams(inputs, requiredParams)

    // create channels from input files
    database = Channel.fromPath("${inputs.database}", checkIfExists: true)
    raw_files = Channel.fromPath("${inputs.raw_files}", checkIfExists: true)
    msf_param_file = Channel.fromPath("${inputs.msf_params_file}", checkIfExists: true)

    emit:
    ch_database       = database
    ch_raws           = raw_files
    ch_msf_param_file = msf_param_file
}

workflow CREATE_INPUT_CHANNEL_MZEXTRACTOR {
    take:
    input_files

    main:

    // read the file with input parameters
    f = new FileInputStream(new File(input_files))
    // create yaml
    inputs = new Yaml().load(f)

    // stop from the missing parameters
    def requiredParams = ['reporter_ion_isotopic']
    getMissingParams(inputs, requiredParams)

    // create channels from input files
    // this file will be used multiple times, so, we create a Value Channel
    File file = new File("${inputs.reporter_ion_isotopic}")
    if ( file.exists() ) {
        reporter_ion_isotopic = Channel.value("${inputs.reporter_ion_isotopic}")
    }
    else {
        exit 1, "ERROR: The 'reporter_ion_isotopic' file does not exist"
    }
    

    emit:
    ch_reporter_ion_isotopic       = reporter_ion_isotopic
}
