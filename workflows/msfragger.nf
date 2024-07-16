/*
========================================================================================
    IMPORT LOCAL MODULES/SUBWORKFLOWS
========================================================================================
*/

include { MSF }               from '../nf-modules/modules/msfragger/main'

/*
========================================================================================
    RUN MAIN WORKFLOW
========================================================================================
*/

workflow MSFRAGGER {

    take:
    raw_files
    database
    decoy_prefix
    output_format
    msf_params_file

    main:
    //
    // SUBMODULE: execute MSFragger
    //
    MSF('01', raw_files, msf_params_file)

    // return channels
    ch_ofile         = MSF.out.ofile

    emit:
    ofile       = ch_ofile
}

/*
========================================================================================
    THE END
========================================================================================
*/
