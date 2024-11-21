/*
========================================================================================
    IMPORT LOCAL MODULES/SUBWORKFLOWS
========================================================================================
*/

include { DECOYPYRAT } from './decoypyrat'
include { THERMORAWPARSER } from './thermorawparser'
include { MSFRAGGER } from './msfragger'
include { MSFRAGGERADAPTED } from './msfraggeradapted'
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
        CREATE_INPUT_CHANNEL_SEARCH_ENGINE.out.ch_database,
        params.add_decoys,
        params.decoy_prefix
    )
    //
    // WORKFLOW: ThermoRawFileParser analysis
    //
    THERMORAWPARSER(
        CREATE_INPUT_CHANNEL_SEARCH_ENGINE.out.ch_raws,
        params.create_mzml
    )
    //
    // Collect raw files, handling the case where THERMORAWPARSER is skipped
    //
    def raw_files = params.create_mzml ? THERMORAWPARSER.out.raws.collect() : CREATE_INPUT_CHANNEL_SEARCH_ENGINE.out.ch_raws.collect()
    //
    // WORKFLOW: Run MSFragger analysis
    //
    MSFRAGGER(
        raw_files,
        DECOYPYRAT.out.target_decoy,
        params.decoy_prefix,
        params.msf_output_format,
        CREATE_INPUT_CHANNEL_SEARCH_ENGINE.out.ch_msf_param_file
    )
    //
    // WORKFLOW: Add Spectrum File and ScanID
    //
    MSFRAGGERADAPTED(
        MSFRAGGER.out.ofile.flatten()
    )
    //
    // WORKFLOW: Run MZ_extractor analysis
    //
    MZEXTRACTOR(
        MSFRAGGERADAPTED.out.ofile,
        THERMORAWPARSER.out.raws,
        CREATE_INPUT_CHANNEL_SEARCH_ENGINE.out.ch_reporter_ion_isotopic
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
        MSFRAGGER.out.ofile.flatten()
    )
    //
    // WORKFLOW: Run MZ_extractor analysis
    //
    MZEXTRACTOR(
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
        CREATE_INPUT_CHANNEL_MSFRAGGERADAPTED.out.ch_msf_files
    )
    //
    // WORKFLOW: Run MZ_extractor analysis
    //
    MZEXTRACTOR(
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
