/*
========================================================================================
    IMPORT LOCAL MODULES/SUBWORKFLOWS
========================================================================================
*/

include { THERMO_RAW_PARSER }       from '../nf-modules/modules/thermo_raw_parser/main'

/*
========================================================================================
    RUN MAIN WORKFLOW
========================================================================================
*/

workflow THERMORAWPARSER {

    take:
    raw_files
    create_mzml

    main:
    //
    // SUBMODULE: convert the raws to [mzML, mzXML, MGF, Parquet]
    //
    THERMO_RAW_PARSER('01', raw_files, create_mzml)

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
