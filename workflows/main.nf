/*
========================================================================================
    IMPORT LOCAL MODULES/SUBWORKFLOWS
========================================================================================
*/

include { DECOYPYRAT } from './decoypyrat'
include { THERMORAWPARSER } from './thermorawparser'
include { MSFRAGGER } from './msfragger'
include { MSFRAGGERADAPTED } from './msfraggeradapted'
include { REFMOD } from './refmod'
include { MZEXTRACTOR } from './mzextractor'

//
// SUBWORKFLOW: Create input channels
//

include {
    CREATE_INPUT_CHANNEL_SEARCH_ENGINE;
    CREATE_INPUT_CHANNEL_DECOYPYRAT;
    CREATE_INPUT_CHANNEL_THERMORAWPARSER;
    CREATE_INPUT_CHANNEL_MSFRAGGER;
    CREATE_INPUT_CHANNEL_MSFRAGGERADAPTED;
    CREATE_INPUT_CHANNEL_MZEXTRACTOR
} from '../nf-modules/subworkflows/search_engine'


//
// WORKFLOW: Run main analysis pipeline
//

workflow SEARCH_ENGINE_WORKFLOW {
    //
    // SUBWORKFLOW: Create input channels
    //
    CREATE_INPUT_CHANNEL_SEARCH_ENGINE()
    //
    // WORKFLOW: DecoyPyRat analysis
    //
    DECOYPYRAT(
        '01',
        params.add_decoys,
        CREATE_INPUT_CHANNEL_SEARCH_ENGINE.out.ch_database,
        params.decoy_prefix
    )
    //
    // WORKFLOW: ThermoRawFileParser analysis
    //
    THERMORAWPARSER(
        '01',
        params.create_mzml,
        CREATE_INPUT_CHANNEL_SEARCH_ENGINE.out.ch_raws
    )
    //
    // WORKFLOW: Run MSFragger analysis
    //
    MSFRAGGER(
        '02',
        THERMORAWPARSER.out.raws.collect(),
        DECOYPYRAT.out.target_decoy,
        params.decoy_prefix,
        params.msf_output_format,
        CREATE_INPUT_CHANNEL_SEARCH_ENGINE.out.ch_msf_param_file
    )
    //
    // WORKFLOW: Add Spectrum File and ScanID
    //
    MSFRAGGERADAPTED(
        '03',
        MSFRAGGER.out.ofile.flatten()
    )
    //
    // WORKFLOW: Run MZ_extractor analysis
    //
    MZEXTRACTOR(
        '04',
        params.add_quant,
        MSFRAGGERADAPTED.out.ofile,
        THERMORAWPARSER.out.raws,
        CREATE_INPUT_CHANNEL_SEARCH_ENGINE.out.ch_reporter_ion_isotopic
    )
    //
    // WORKFLOW: Execute REFMOD
    //
    REFMOD(
        '05',
        params.exec_refmod,
        MZEXTRACTOR.out.ofile,
        THERMORAWPARSER.out.raws,
        CREATE_INPUT_CHANNEL_SEARCH_ENGINE.out.ch_dm_file,
        CREATE_INPUT_CHANNEL_SEARCH_ENGINE.out.ch_refmod_param_file
    )
}

workflow DECOYPYRAT_WORKFLOW {
    //
    // SUBWORKFLOW: Create input channels
    //
    CREATE_INPUT_CHANNEL_DECOYPYRAT()
    //
    // WORKFLOW: DecoyPyRat analysis
    //
    DECOYPYRAT(
        '00',
        CREATE_INPUT_CHANNEL_DECOYPYRAT.out.ch_database,
        params.add_decoys,
        params.decoy_prefix
    )
}

workflow THERMORAWPARSER_WORKFLOW {
    //
    // SUBWORKFLOW: Create input channels
    //
    CREATE_INPUT_CHANNEL_THERMORAWPARSER()
    //
    // WORKFLOW: ThermoRawFileParser analysis
    //
    THERMORAWPARSER(
        '00',
        CREATE_INPUT_CHANNEL_THERMORAWPARSER.out.ch_raws,
        params.create_mzml
    )
}

workflow MSFRAGGER_WORKFLOW {
    //
    // SUBWORKFLOW: Create input channels
    //
    CREATE_INPUT_CHANNEL_MSFRAGGER()
    CREATE_INPUT_CHANNEL_MZEXTRACTOR()
    //
    // WORKFLOW: Run MSFragger analysis
    //
    MSFRAGGER(
        '00',
        CREATE_INPUT_CHANNEL_MSFRAGGER.out.ch_raws,
        CREATE_INPUT_CHANNEL_MSFRAGGER.out.ch_database,
        params.decoy_prefix,
        params.msf_output_format,
        CREATE_INPUT_CHANNEL_MSFRAGGER.out.ch_msf_param_file
    )
    //
    // WORKFLOW: Add Spectrum File and ScanID
    //
    MSFRAGGERADAPTED(
        '00',
        MSFRAGGER.out.ofile.flatten()
    )
    //
    // WORKFLOW: Run MZ_extractor analysis
    //
    MZEXTRACTOR(
        '00',
        MSFRAGGER.out.ofile,
        CREATE_INPUT_CHANNEL_MSFRAGGER.out.ch_raws,
        CREATE_INPUT_CHANNEL_MZEXTRACTOR.out.ch_reporter_ion_isotopic
    )
}

workflow MSFRAGGERADAPTED_WORKFLOW {
    //
    // SUBWORKFLOW: Create input channels
    //
    CREATE_INPUT_CHANNEL_MSFRAGGERADAPTED()
    //
    // WORKFLOW: Add Spectrum File and ScanID
    //
    MSFRAGGERADAPTED(
        '00',
        CREATE_INPUT_CHANNEL_MSFRAGGERADAPTED.out.ch_msf_files
    )
    //
    // WORKFLOW: Run MZ_extractor analysis
    //
    MZEXTRACTOR(
        '00',
        MSFRAGGERADAPTED.out.ofile,
        CREATE_INPUT_CHANNEL_MSFRAGGERADAPTED.out.ch_mz_files,
        CREATE_INPUT_CHANNEL_MSFRAGGERADAPTED.out.ch_reporter_ion_isotopic
    )
}

/*
========================================================================================
    THE END
========================================================================================
*/
