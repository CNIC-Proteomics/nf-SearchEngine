/*
========================================================================================
    IMPORT LOCAL MODULES/SUBWORKFLOWS
========================================================================================
*/

include { MSF }               from '../modules/msfragger/main'
include { MZ_EXTRACTOR }      from '../modules/mz_extractor/main'

/*
========================================================================================
    RUN MAIN WORKFLOW
========================================================================================
*/

// workflow MSFRAGGER {

//     take:
//     raw_files
//     database
//     decoy_prefix
//     output_format
//     msf_params_file

//     main:
//     //
//     // SUBMODULE: execute MSFragger
//     //
//     MSF(raw_files, database, decoy_prefix, output_format, msf_params_file)

//     // return channels
//     ch_ofile         = MSF.out.ofile
//     ch_ofile_param   = MSF.out.ofile_param

//     emit:
//     ofile       = ch_ofile
//     ofile_param = ch_ofile_param
// }

workflow MSFRAGGER {

    take:
    raw_files
    database
    decoy_prefix
    output_format
    msf_params_file
    reporter_ion_isotopic

    main:
    //
    // SUBMODULE: execute MSFragger
    //
    MSF(raw_files, database, decoy_prefix, output_format, msf_params_file)

    MZ_EXTRACTOR(MSF.out.ofile, raw_files, reporter_ion_isotopic)

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
