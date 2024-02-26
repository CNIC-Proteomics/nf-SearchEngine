/*
========================================================================================
    IMPORT LOCAL MODULES/SUBWORKFLOWS
========================================================================================
*/

include { THERMO_RAW_PARSER }       from '../modules/thermo_raw_parser/main'

/*
========================================================================================
    RUN MAIN WORKFLOW
========================================================================================
*/

workflow THERMORAWPARSER {

    take:
    raw_files

    main:
    //
    // SUBMODULE: convert the raws to [mzML, mzXML, MGF, Parquet]
    //
    THERMO_RAW_PARSER(raw_files)

    // return channels
    ch_raws   = THERMO_RAW_PARSER.out.ofile

    emit:
    raws = ch_raws
}

/*
========================================================================================
    THE END
========================================================================================
*/
