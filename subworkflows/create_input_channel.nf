//
// Create channel for input files
//


/*
========================================================================================
    IMPORT MODULES
========================================================================================
*/

import org.yaml.snakeyaml.Yaml

/*
========================================================================================
    LOCAL FUNCIOTNS
========================================================================================
*/


// Define a function to check which parameters are missing
def getMissingParams(params, required_params) {
    def missingParams = []
    // Iterate over each parameter in the list
    for (param in required_params) {
        // Check if the parameter exists in the params
        if (!params.containsKey(param)) {
            // If parameter is missing, add it to the list of missing parameters
            missingParams.add(param)
        }
    }
    // Return the list of missing parameters
    return missingParams
}

// Print an error message for the missing parameters
def printErrorMissingParams(params, required_params) {
    // check which parameters are missing in the dict
    def missingParams = getMissingParams(params, required_params)
    // stop from the missing parameters
    if (!missingParams.isEmpty()) {
        exit 1, "ERROR: Missing parameters: ${missingParams}"
    }
}

// Join two channels based on the file name
def joinChannelsFromFilename(ifiles1, ifiles2) {

    // create a list of tuples with the base name and the file name.
    def files1 = ifiles1
                    // .flatten()
                    .map{  file -> tuple(file.baseName, file) }
                    // .view()
                    // .set { files1 }

    // create a list of tuples with the base name and the file name.
    def files2 = ifiles2
                    .map { file -> tuple(file.baseName, file) }
                    // .view()
                    // .set { files2 }

    // join both channels based on the first element (base name)
    def files3 = files1
                    .join(files2)
                    .map { name, f1, f2 -> [f1, f2] }
                    // .view { "value: $it" }
                    // .set { files3 }

    return files3
}

/*
========================================================================================
    DEFINED WORKFLOWS
========================================================================================
*/

workflow CREATE_INPUT_CHANNEL_SEARCH_ENGINE {
    main:

    // stop from the missing parameters
    def requiredParams = ['raw_files','database','msf_params_file','reporter_ion_isotopic']
    printErrorMissingParams(params, requiredParams)

    // create channels from input files
    raw_files = Channel.fromPath("${params.raw_files}", checkIfExists: true)
    database = Channel.fromPath("${params.database}", checkIfExists: true)

    // update the given parameter into the fixed parameter file
    def redefinedParams = ['database_name': params.database, 'decoy_prefix': params.decoy_prefix, 'output_format': params.msf_output_format]
    def updated_params_str = Utils.updateParamsFile(params.msf_params_file, redefinedParams)
    def updated_params_file = Utils.writeStrIntoFile(updated_params_str, "${params.paramdir}/msfragger.params")

    // create channel for params file
    msf_param_file = Channel.value("${updated_params_file}")

    // create channels from input files
    // this file will be used multiple times, so, we have to create a Value Channel and then, check if file exists
    File file = new File("${params.reporter_ion_isotopic}")
    if ( file.exists() ) {
        reporter_ion_isotopic = Channel.value("${params.reporter_ion_isotopic}")
    }
    else {
        exit 1, "ERROR: The 'reporter_ion_isotopic' file does not exist"
    }


    emit:
    ch_raws                   = raw_files
    ch_database               = database
    ch_msf_param_file         = msf_param_file
    ch_reporter_ion_isotopic  = reporter_ion_isotopic
}

workflow CREATE_INPUT_CHANNEL_DECOYPYRAT {
    main:

    // stop from the missing parameters
    def requiredParams = ['database']
    printErrorMissingParams(params, requiredParams)

    // create channels from input files
    database = Channel.fromPath("${params.database}", checkIfExists: true)

    emit:
    ch_database       = database
}

workflow CREATE_INPUT_CHANNEL_THERMORAWPARSER {
    main:

    // stop from the missing parameters
    def requiredParams = ['raw_files']
    printErrorMissingParams(params, requiredParams)

    // create channels from input files
    raw_files = Channel.fromPath("${params.raw_files}", checkIfExists: true)

    emit:
    ch_raws           = raw_files
}

workflow CREATE_INPUT_CHANNEL_MSFRAGGER {
    main:

    // stop from the missing parameters
    def requiredParams = ['raw_files','database','msf_params_file']
    printErrorMissingParams(params, requiredParams)

    // create channels from input files
    raw_files = Channel.fromPath("${params.raw_files}", checkIfExists: true)
    database = Channel.fromPath("${params.database}", checkIfExists: true)
    msf_param_file = Channel.fromPath("${params.msf_params_file}", checkIfExists: true)

    emit:
    ch_raws           = raw_files
    ch_database       = database
    ch_msf_param_file = msf_param_file
}

workflow CREATE_INPUT_CHANNEL_MZEXTRACTOR {
    main:

    // stop from the missing parameters
    def requiredParams = ['reporter_ion_isotopic']
    printErrorMissingParams(params, requiredParams)

    // create channels from input files
    // this file will be used multiple times, so, we have to create a Value Channel and then, check if file exists
    File file = new File("${params.reporter_ion_isotopic}")
    if ( file.exists() ) {
        reporter_ion_isotopic = Channel.value("${params.reporter_ion_isotopic}")
    }
    else {
        exit 1, "ERROR: The 'reporter_ion_isotopic' file does not exist"
    }
    
    emit:
    ch_reporter_ion_isotopic       = reporter_ion_isotopic
}
