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
    database
    add_decoys
    decoy_prefix

    main:
    //
    // SUBMODULE: obtain the decoy fasta file
    //
    DECOY_PY_RAT('01', database, add_decoys, decoy_prefix)

    // return channels
    ch_target_decoy   = DECOY_PY_RAT.out.ofile
    ch_target         = DECOY_PY_RAT.out.ofile_target
    ch_decoy          = DECOY_PY_RAT.out.ofile_decoy

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
