//
// Create channel for input file
//

import org.yaml.snakeyaml.Yaml


// # Raw files for Search engine (MSFragger)
// raw_files: /mnt/tierra/nf-SearchEngine/tests/test1/raws/*.raw

// # FASTA file for DecoyPYrat and Search engine (MSFragger)
// database_name: '/mnt/tierra/nf-SearchEngine/tests/test1/dbs/human_202105_pro-sw.fasta'

// # MSFragger options
// msf_params_file: '/mnt/tierra/nf-SearchEngine/tests/test1/params/closed_fragger.params'

// # MZ_extractor options
// reporter_ion_isotopic: '/mnt/tierra/nf-SearchEngine/tests/test1/params/reporter_ion_isotopic.tsv'

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
    // Return the list of missing parameters
    return missingParams
}


workflow CREATE_INPUT_CHANNEL_DECOYPYRAT {
    take:
    input_files
    // params_file

    main:

    // read the file with input parameters
    fi = new FileInputStream(new File(input_files))
    // create yaml
    inputs = new Yaml().load(fi)

    // create channels from input files
    database = Channel.fromPath("${inputs.database}", checkIfExists: true)

    // // add the parameters into params variable
    // def fp = new FileInputStream(new File(params_file))
    // new Yaml().load(fp).each({ k, v -> params[k] = v })
    // println "PARAMS-1: ${params}"

    // // required parameters
    // def requiredParams = ['add_decoys', 'decoy_prefix']

    // // get the list of missing parameters
    // def missingParams = getMissingParams(params, requiredParams)

    // // stop from the missing parameters
    // if (!missingParams.isEmpty()) {
    //     exit 1, "ERROR: Missing parameters in dictionary: ${missingParams}"
    // }

    emit:
    ch_database   = database
}

workflow CREATE_INPUT_CHANNEL_MSFRAGGER {
    take:
    input_files
    params_file

    main:

    // read the file with input parameters
    f = new FileInputStream(new File(input_files))
    // create yaml
    inputs = new Yaml().load(f)

    // create channels from input files
    raw_files = Channel.fromPath("${inputs.raw_files}", checkIfExists: true)
    database = Channel.fromPath("${inputs.database}", checkIfExists: true)
    msf_params_file = Channel.fromPath("${inputs.msf_params_file}", checkIfExists: true)

    // add the parameters into params variable
    f = new FileInputStream(new File(param_file))
    new Yaml().load(f).each({ k, v -> params[k] = v })

    emit:
    ch_raws           = raw_files
    ch_database       = database
    ch_msf_param_file = msf_params_file
}