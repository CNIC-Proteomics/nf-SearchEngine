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
    tag_order
    create_mzml
    raw_files

    main:
    //
    // SUBMODULE: convert the raws to [mzML, mzXML, MGF, Parquet]
    //

    // optional process that depens on the given flag variable
    if ( create_mzml ) {
        THERMO_RAW_PARSER(tag_order, raw_files)
        
        ch_raws = THERMO_RAW_PARSER.out.ofile
    }
    // does not execute the process, the output is the same than input
    else {
        ch_raws = raw_files
    }

    // return channels
    emit:
    raws = ch_raws
}

/*
========================================================================================
    THE END
========================================================================================
*/
