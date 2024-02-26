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
include { THERMORAWPARSER } from './workflows/thermorawparser'
include { MSFRAGGER } from './workflows/msfragger'
include { MZEXTRACTOR } from './workflows/mzextractor'

//
// SUBWORKFLOW: Create input channels
//

include {
    CREATE_INPUT_CHANNEL_DECOYPYRAT;
    CREATE_INPUT_CHANNEL_THERMORAWPARSER;
    CREATE_INPUT_CHANNEL_MSFRAGGER;
    CREATE_INPUT_CHANNEL_MZEXTRACTOR
} from './subworkflows/create_input_channel'




//
// WORKFLOW: Run main analysis pipeline
//

workflow SEARCH_ENGINE {
    // //
    // // SUBWORKFLOW: Create input channels
    // //
    // CREATE_INFILES_CHANNEL (
    //     params.input_files
    // )
    // ch_database_name = CREATE_INFILE_CHANNEL ( params.database_name )
    // ch_reporter_ion_isotopic = CREATE_INFILE_CHANNEL ( params.reporter_ion_isotopic )
    // //
    // // WORKFLOW: ThermoRawFileParser analysis
    // //
    // DECOYPYRAT(ch_database_name, params.add_decoys, params.decoy_prefix)
    // //
    // // WORKFLOW: ThermoRawFileParser analysis
    // //
    // THERMO_RAW_PARSER(CREATE_INFILES_CHANNEL.out.input_file)
    // //
    // // WORKFLOW: Run MSFragger analysis
    // //
    // MSFRAGGER(THERMO_RAW_PARSER.out.ofile.collect(), DECOYPYRAT.out.ofile, params.decoy_prefix, params.msf_output_format, params.msf_params_file)
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
    // SUBWORKFLOW: Create input channels
    //
    CREATE_INPUT_CHANNEL_DECOYPYRAT (
        params.inputs
    )
    CREATE_INPUT_CHANNEL_THERMORAWPARSER (
        params.inputs
    )
    CREATE_INPUT_CHANNEL_MSFRAGGER (
        params.inputs
    )
    CREATE_INPUT_CHANNEL_MZEXTRACTOR (
        params.inputs
    )
    //
    // WORKFLOW: DecoyPyRat analysis
    //
    DECOYPYRAT(
        CREATE_INPUT_CHANNEL_DECOYPYRAT.out.ch_database,
        params.add_decoys,
        params.decoy_prefix
    )
    //
    // WORKFLOW: ThermoRawFileParser analysis
    //
    THERMORAWPARSER(
        CREATE_INPUT_CHANNEL_THERMORAWPARSER.out.ch_raws
    )
    //
    // WORKFLOW: Run MSFragger analysis
    //
    MSFRAGGER(
        THERMORAWPARSER.out.raws.collect(),
        DECOYPYRAT.out.target_decoy,
        params.decoy_prefix,
        params.msf_output_format,
        CREATE_INPUT_CHANNEL_MSFRAGGER.out.ch_msf_param_file
    )
    //
    // WORKFLOW: Run MZ_extractor analysis
    //
    // MZ_EXTRACTOR(MSFRAGGER.out.ofile.collect(), THERMO_RAW_PARSER.out.ofile.collect(), ch_reporter_ion_isotopic)
    MZEXTRACTOR(
        MSFRAGGER.out.ofile,
        THERMORAWPARSER.out.raws,
        CREATE_INPUT_CHANNEL_MZEXTRACTOR.out.ch_reporter_ion_isotopic
    )
}

workflow DECOYPYRAT_WORKFLOW {
    //
    // SUBWORKFLOW: Create input channels
    //
    CREATE_INPUT_CHANNEL_DECOYPYRAT (
        params.inputs
    )
    //
    // WORKFLOW: DecoyPyRat analysis
    //
    DECOYPYRAT(
        CREATE_INPUT_CHANNEL_DECOYPYRAT.out.ch_database,
        params.add_decoys,
        params.decoy_prefix
    )
}

workflow THERMORAWPARSER_WORKFLOW {
    //
    // SUBWORKFLOW: Create input channels
    //
    CREATE_INPUT_CHANNEL_THERMORAWPARSER (
        params.inputs
    )
    //
    // WORKFLOW: ThermoRawFileParser analysis
    //
    THERMORAWPARSER(
        CREATE_INPUT_CHANNEL_THERMORAWPARSER.out.ch_raws
    )
}

workflow MSFRAGGER_WORKFLOW {
    //
    // SUBWORKFLOW: Create input channels
    //
    CREATE_INPUT_CHANNEL_DECOYPYRAT (
        params.inputs
    )
    CREATE_INPUT_CHANNEL_THERMORAWPARSER (
        params.inputs
    )
    CREATE_INPUT_CHANNEL_MSFRAGGER (
        params.inputs
    )
    //
    // WORKFLOW: Run MSFragger analysis
    //
    MSFRAGGER(
        CREATE_INPUT_CHANNEL_THERMORAWPARSER.out.raws.collect(),
        CREATE_INPUT_CHANNEL_DECOYPYRAT.out.ch_database,
        params.decoy_prefix,
        params.msf_output_format,
        CREATE_INPUT_CHANNEL_MSFRAGGER.out.ch_msf_param_file
    )
}

workflow MZEXTRACTOR_WORKFLOW {
    //
    // SUBWORKFLOW: Create input channels
    //
    CREATE_INPUT_CHANNEL_DECOYPYRAT (
        params.inputs
    )
    CREATE_INPUT_CHANNEL_THERMORAWPARSER (
        params.inputs
    )
    CREATE_INPUT_CHANNEL_MSFRAGGER (
        params.inputs
    )
    //
    // WORKFLOW: Run MSFragger analysis
    //
    MSFRAGGER(
        CREATE_INPUT_CHANNEL_THERMORAWPARSER.out.raws.collect(),
        CREATE_INPUT_CHANNEL_DECOYPYRAT.out.ch_database,
        params.decoy_prefix,
        params.msf_output_format,
        CREATE_INPUT_CHANNEL_MSFRAGGER.out.ch_msf_param_file
    )
}

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
