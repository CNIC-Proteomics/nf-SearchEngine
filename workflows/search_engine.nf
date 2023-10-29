/*
========================================================================================
    VALIDATE INPUTS
========================================================================================
*/


/*
========================================================================================
    CONFIG FILES
========================================================================================
*/


/*
========================================================================================
    IMPORT LOCAL MODULES/SUBWORKFLOWS
========================================================================================
*/

// include { DECOY_PY_RAT } from './decoypyrat'
include { DECOY_PY_RAT }            from '../modules/decoypyrat/main'
include { THERMO_RAW_PARSER }       from '../modules/thermo_raw_parser/main'
include { MSFRAGGER }               from '../modules/msfragger/main'
include { MZ_EXTRACTOR }            from '../modules/mz_extractor/main'
// include { REFRAG }                  from '../modules/msf/main'


//
// SUBWORKFLOW: Consisting of a mix of local and nf-core/modules
//

include { CREATE_INFILES_CHANNEL; CREATE_INFILE_CHANNEL } from '../subworkflows/create_input_channel'



/*
========================================================================================
    IMPORT NF-CORE MODULES/SUBWORKFLOWS
========================================================================================
*/

//
// MODULE: Installed directly from nf-core/modules
//

// include { CUSTOM_DUMPSOFTWAREVERSIONS } from '../modules/nf-core/custom/dumpsoftwareversions/main'



/*
========================================================================================
    RUN MAIN WORKFLOW
========================================================================================
*/

// Info required for completion email and summary
def info_report = []

workflow SEARCH_ENGINE {

    //
    // SUBWORKFLOW: Create input channel
    //
    CREATE_INFILES_CHANNEL (
        params.input_files
    )
    ch_database_name = CREATE_INFILE_CHANNEL ( params.database_name )
    ch_reporter_ion_isotopic = CREATE_INFILE_CHANNEL ( params.reporter_ion_isotopic )


    //
    // WORKFLOW: ThermoRawFileParser analysis
    //
    DECOY_PY_RAT(ch_database_name, params.add_decoys, params.decoy_prefix)


    //
    // WORKFLOW: ThermoRawFileParser analysis
    //
    THERMO_RAW_PARSER(CREATE_INFILES_CHANNEL.out.input_file)


    //
    // WORKFLOW: Run MSFragger analysis
    //
    MSFRAGGER(THERMO_RAW_PARSER.out.ofile.collect(), DECOY_PY_RAT.out.ofile, params.decoy_prefix, params.msf_output_format, params.msf_params_file)


    //
    // WORKFLOW: Run MZ_extractor analysis
    //
    // MZ_EXTRACTOR(MSFRAGGER.out.ofile.collect(), THERMO_RAW_PARSER.out.ofile.collect(), ch_reporter_ion_isotopic)
    // println("FLATTEN: ${MSFRAGGER.out.ofile.flatten().view()}")
    // println("MZML: ${THERMO_RAW_PARSER.out.ofile.view()}")
    a = MSFRAGGER.out.ofile.flatten().combine( THERMO_RAW_PARSER.out.ofile).view()
    println("COMBINE: ${a}")
    // MZ_EXTRACTOR(MSFRAGGER.out.ofile.flatten(), THERMO_RAW_PARSER.out.ofile, ch_reporter_ion_isotopic)
    

}

/*
========================================================================================
    COMPLETION EMAIL AND SUMMARY
========================================================================================
*/

// workflow.onComplete {
//     if (params.email || params.email_on_fail) {
//         NfcoreTemplate.email(workflow, params, summary_params, projectDir, log, info_report)
//     }
//     NfcoreTemplate.summary(workflow, params, log)
//     if (params.hook_url) {
//         NfcoreTemplate.IM_notification(workflow, params, summary_params, projectDir, log)
//     }
// }

/*
========================================================================================
    THE END
========================================================================================
*/
