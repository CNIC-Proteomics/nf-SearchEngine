/*
========================================================================================
    IMPORT LOCAL MODULES/SUBWORKFLOWS
========================================================================================
*/

include { DECOY_PY_RAT }            from '../nf-modules/modules/decoypyrat/main'

/*
========================================================================================
    RUN MAIN WORKFLOW
========================================================================================
*/

workflow DECOYPYRAT {

    take:
    add_decoys
    database
    decoy_prefix

    main:
    //
    // SUBMODULE: obtain the decoy fasta file
    //

    // optional process that depens on the given flag variable
    if ( add_decoys ) {
        DECOY_PY_RAT('01', database, decoy_prefix)

        ch_target_decoy   = DECOY_PY_RAT.out.ofile
        ch_target         = DECOY_PY_RAT.out.ofile_target
        ch_decoy          = DECOY_PY_RAT.out.ofile_decoy
    }
    // does not execute the process, the output is the same than input
    else {
        ch_target_decoy   = database
        ch_target         = Channel.empty()
        ch_decoy          = Channel.empty()
    }

    // return channels
    emit:
    target_decoy = ch_target_decoy
    target       = ch_target
    decoy        = ch_decoy
}

/*
========================================================================================
    THE END
========================================================================================
*/
