/*
========================================================================================
    IMPORT MODULES
========================================================================================
*/

include { joinChannelsFromFilename } from '../nf-modules/lib/Utils'

/*
========================================================================================
    IMPORT LOCAL MODULES/SUBWORKFLOWS
========================================================================================
*/

include { REF_MOD }            from '../nf-modules/modules/refmod/main'

/*
========================================================================================
    RUN MAIN WORKFLOW
========================================================================================
*/

workflow REFMOD {

    take:
    exec_refmod
    ident_files
    mzml_files
    dm_file
    params_file

    main:
    //
    // SUBMODULE: execute REFMOD
    //

    // optional process that depends on the given parameter variable
    if ( exec_refmod && dm_file.name.val != 'NO_FILE' && params_file.name.val != 'NO_FILE' ) {
        
        // join two channels based on the file name
        ident_quant_files = joinChannelsFromFilename(ident_files, mzml_files)

        // execute the process
        REF_MOD('01', ident_quant_files, dm_file, params_file)

        ch_ofile         = REF_MOD.out.ofile
        ch_summary_file  = REF_MOD.out.summary_file
    }
    // does not execute the process, the output is the same than input
    else {
        ch_ofile = ident_files
    }

    // return channels
    emit:
    ofile       = ch_ofile
}

/*
========================================================================================
    THE END
========================================================================================
*/
