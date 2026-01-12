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
include { REFMOD } from './refmod'

//
// SUBWORKFLOW: Create input channels
//

include { CREATE_INPUT_CHANNEL_SEARCH_ENGINE } from '../nf-modules/subworkflows/search_engine'


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
        CREATE_INPUT_CHANNEL_SEARCH_ENGINE.out.ch_raw_files
    )
    //
    // WORKFLOW: Run MSFragger analysis
    //
    MSFRAGGER(
        '02',
        THERMORAWPARSER.out.raws.collect(),
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
        MZEXTRACTOR.out.ofile,
        THERMORAWPARSER.out.raws,
        CREATE_INPUT_CHANNEL_SEARCH_ENGINE.out.ch_dm_file,
        CREATE_INPUT_CHANNEL_SEARCH_ENGINE.out.ch_refmod_param_file
    )
}


/*
========================================================================================
    THE END
========================================================================================
*/
