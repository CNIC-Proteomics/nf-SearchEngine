/*
========================================================================================
    IMPORT LOCAL MODULES/SUBWORKFLOWS
========================================================================================
*/

include { MSF }               from '../modules/msfragger/main'

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
    MSF('01', raw_files, database, decoy_prefix, output_format, msf_params_file)

    // return channels
    ch_ofile         = MSF.out.ofile
    ch_ofile_param   = MSF.out.ofile_param

    emit:
    ofile       = ch_ofile
    ofile_param = ch_ofile_param
}

/*
========================================================================================
    THE END
========================================================================================
*/
