#!/usr/bin/env nextflow
/*
========================================================================================
    SearchSengine
========================================================================================
    Github : https://github.com/CNIC-Proteomics/nf-SearchEngine
----------------------------------------------------------------------------------------
*/

nextflow.enable.dsl = 2

/*
========================================================================================
    VALIDATE & PRINT PARAMETER SUMMARY
========================================================================================
*/

// WorkflowMain.initialise(workflow, params, log)

/*
========================================================================================
    IMPORT LOCAL MODULES/SUBWORKFLOWS
========================================================================================
*/

// include { SEARCH_ENGINE } from './workflows/search_engine'
include { DECOYPYRAT } from './workflows/decoypyrat'
// include { THERMORAWPARSER } from './workflows/thermorawparser'
// include { MSFRAGGER } from './workflows/msfragger'
// include { MZEXTRACTOR } from './workflows/mzextractor'

//
// SUBWORKFLOW: Create input channels
//

include { CREATE_INPUT_CHANNEL_DECOYPYRAT ; CREATE_INPUT_CHANNEL_MSFRAGGER } from './subworkflows/create_input_channel'




//
// WORKFLOW: Run main analysis pipeline
//

workflow SEARCH_ENGINE {
    // //
    // // SUBWORKFLOW: Create input channel
    // //
    // CREATE_INFILES_CHANNEL (
    //     params.input_files
    // )
    // ch_database_name = CREATE_INFILE_CHANNEL ( params.database_name )
    // ch_reporter_ion_isotopic = CREATE_INFILE_CHANNEL ( params.reporter_ion_isotopic )
    // //
    // // WORKFLOW: ThermoRawFileParser analysis
    // //
    // DECOY_PY_RAT(ch_database_name, params.add_decoys, params.decoy_prefix)
    // //
    // // WORKFLOW: ThermoRawFileParser analysis
    // //
    // THERMO_RAW_PARSER(CREATE_INFILES_CHANNEL.out.input_file)
    // //
    // // WORKFLOW: Run MSFragger analysis
    // //
    // MSFRAGGER(THERMO_RAW_PARSER.out.ofile.collect(), DECOY_PY_RAT.out.ofile, params.decoy_prefix, params.msf_output_format, params.msf_params_file)
    // //
    // // WORKFLOW: Run MZ_extractor analysis
    // //
    // // MZ_EXTRACTOR(MSFRAGGER.out.ofile.collect(), THERMO_RAW_PARSER.out.ofile.collect(), ch_reporter_ion_isotopic)
    // // println("FLATTEN: ${MSFRAGGER.out.ofile.flatten().view()}")
    // // println("MZML: ${THERMO_RAW_PARSER.out.ofile.view()}")
    // a = MSFRAGGER.out.ofile.flatten().combine( THERMO_RAW_PARSER.out.ofile).view()
    // println("COMBINE: ${a}")
    // // MZ_EXTRACTOR(MSFRAGGER.out.ofile.flatten(), THERMO_RAW_PARSER.out.ofile, ch_reporter_ion_isotopic)

    //
    // SUBWORKFLOW: Create input channel
    //
    CREATE_INPUT_CHANNEL_DECOYPYRAT (
        params.inputs,
        params.params_file
    )
    //
    // WORKFLOW: DecoyPyRat analysis
    //
    DECOY_PY_RAT(
        CREATE_INPUT_CHANNEL_DECOYPYRAT.out.ch_database,
        params.add_decoys,
        params.decoy_prefix
    )
}

// workflow DECOYPYRAT_WORKFLOW {
//     //
//     // SUBWORKFLOW: Create input channel
//     //
//     CREATE_INFILES_CHANNEL (
//         params.input_files
//     )
//     ch_database_name = CREATE_INFILE_CHANNEL ( params.database_name )
//     ch_reporter_ion_isotopic = CREATE_INFILE_CHANNEL ( params.reporter_ion_isotopic )
//     //
//     // WORKFLOW: ThermoRawFileParser analysis
//     //
//     DECOY_PY_RAT(ch_database_name, params.add_decoys, params.decoy_prefix)
// }

// workflow MSFRAGGER_WORKFLOW {
//     //
//     // SUBWORKFLOW: Create input channel
//     //
//     CREATE_INFILES_CHANNEL (
//         params.input_files
//     )
//     ch_database_name = CREATE_INFILE_CHANNEL ( params.database_name )
//     ch_reporter_ion_isotopic = CREATE_INFILE_CHANNEL ( params.reporter_ion_isotopic )
//     //
//     // WORKFLOW: ThermoRawFileParser analysis
//     //
//     THERMO_RAW_PARSER(CREATE_INFILES_CHANNEL.out.input_file)
//     //
//     // WORKFLOW: Run MSFragger analysis
//     //
//     MSFRAGGER(THERMO_RAW_PARSER.out.ofile.collect(), DECOY_PY_RAT.out.ofile, params.decoy_prefix, params.msf_output_format, params.msf_params_file)
//     //
//     // WORKFLOW: Run MZ_extractor analysis
//     //
//     // MZ_EXTRACTOR(MSFRAGGER.out.ofile.collect(), THERMO_RAW_PARSER.out.ofile.collect(), ch_reporter_ion_isotopic)
//     // println("FLATTEN: ${MSFRAGGER.out.ofile.flatten().view()}")
//     // println("MZML: ${THERMO_RAW_PARSER.out.ofile.view()}")
//     a = MSFRAGGER.out.ofile.flatten().combine( THERMO_RAW_PARSER.out.ofile).view()
//     println("COMBINE: ${a}")
//     // MZ_EXTRACTOR(MSFRAGGER.out.ofile.flatten(), THERMO_RAW_PARSER.out.ofile, ch_reporter_ion_isotopic)
// }

/*
========================================================================================
    RUN ALL WORKFLOWS
========================================================================================
*/
// Info required for completion email and summary
def multiqc_report = []

//
// WORKFLOW: Execute a single named workflow for the pipeline
//
workflow {

    // Select the type of workflow
    if ( 'search_engine' == params.wkf ) {
        SEARCH_ENGINE()
    // } else if ( 'decoypyrat' == params.wkf ) {
    //     DECOYPYRAT_WORKFLOW()
    // } else if ( 'msfragger' == params.wkf ) {
    //     MSFRAGGER_WORKFLOW()
    } else {
        println "Define a correct workflow: [ptm_compass,shifts,solver]"
    }
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
